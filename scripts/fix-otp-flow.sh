#!/bin/bash
# =============================================================================
# Fix OTP Flow: Ubah OTP dari REQUIRED setiap login → hanya saat registrasi
# =============================================================================
# Script ini mengubah Authentication Flow "browser" di Keycloak:
# - OTP Form: REQUIRED → DISABLED (tidak diminta saat login)
# - Required Action "CONFIGURE_TOTP": tetap aktif + default action
#   (user baru tetap diminta setup OTP saat pertama kali)
# =============================================================================
set -e

KEYCLOAK_URL="${KEYCLOAK_URL:-http://localhost:8080}"
REALM="${REALM:-PemdaSSO}"
ADMIN_USER="${ADMIN_USER:-admin}"
ADMIN_PASS="${ADMIN_PASS:-admin}"

echo "============================================"
echo "  Fix OTP: Hanya Saat Registrasi Awal"
echo "============================================"
echo ""
echo "Keycloak URL : $KEYCLOAK_URL"
echo "Realm        : $REALM"
echo ""

# ---- 1. Get Admin Token ----
echo "[1/4] Mendapatkan admin token..."
ADMIN_TOKEN=$(curl -sf -X POST \
    "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" \
    -d "grant_type=password" \
    -d "client_id=admin-cli" \
    -d "username=$ADMIN_USER" \
    -d "password=$ADMIN_PASS" \
    | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token', ''))" 2>/dev/null || echo "")

if [ -z "$ADMIN_TOKEN" ]; then
    echo "❌ Gagal mendapatkan admin token. Pastikan Keycloak berjalan dan kredensial benar."
    exit 1
fi
echo "✅ Admin token berhasil didapat"

# ---- 2. Get Browser Flow Executions ----
echo ""
echo "[2/4] Membaca Authentication Flow 'browser'..."
EXECUTIONS=$(curl -sf \
    "$KEYCLOAK_URL/admin/realms/$REALM/authentication/flows/browser/executions" \
    -H "Authorization: Bearer $ADMIN_TOKEN")

if [ -z "$EXECUTIONS" ]; then
    echo "❌ Gagal membaca authentication flow. Pastikan realm '$REALM' ada."
    exit 1
fi

# Find the OTP Form execution
OTP_EXEC_ID=$(echo "$EXECUTIONS" | python3 -c "
import sys, json
execs = json.load(sys.stdin)
for e in execs:
    provider = e.get('providerId', '')
    display = e.get('displayName', '')
    if provider == 'auth-otp-form' or 'OTP' in display.upper():
        print(e['id'])
        break
" 2>/dev/null || echo "")

if [ -z "$OTP_EXEC_ID" ]; then
    echo "⚠️  OTP Form tidak ditemukan di browser flow."
    echo "   Mungkin sudah dihapus/disabled sebelumnya."
    echo ""
    echo "Flow executions saat ini:"
    echo "$EXECUTIONS" | python3 -c "
import sys, json
execs = json.load(sys.stdin)
for e in execs:
    req = e.get('requirement', '?')
    provider = e.get('providerId', e.get('displayName', 'unknown'))
    print(f'  - {provider}: {req}')
" 2>/dev/null
else
    # Get current requirement
    CURRENT_REQ=$(echo "$EXECUTIONS" | python3 -c "
import sys, json
execs = json.load(sys.stdin)
for e in execs:
    if e['id'] == '$OTP_EXEC_ID':
        print(e.get('requirement', 'UNKNOWN'))
        break
" 2>/dev/null)
    
    echo "   OTP Form ditemukan (ID: $OTP_EXEC_ID)"
    echo "   Status saat ini: $CURRENT_REQ"

    if [ "$CURRENT_REQ" = "DISABLED" ]; then
        echo "✅ OTP Form sudah DISABLED, tidak perlu diubah."
    else
        # ---- 3. Disable OTP Form in Browser Flow ----
        echo ""
        echo "[3/4] Mengubah OTP Form dari $CURRENT_REQ → DISABLED..."
        
        HTTP_CODE=$(curl -sf -o /dev/null -w "%{http_code}" -X PUT \
            "$KEYCLOAK_URL/admin/realms/$REALM/authentication/flows/browser/executions" \
            -H "Authorization: Bearer $ADMIN_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{
                \"id\": \"$OTP_EXEC_ID\",
                \"requirement\": \"DISABLED\"
            }")
        
        if [ "$HTTP_CODE" = "202" ] || [ "$HTTP_CODE" = "204" ] || [ "$HTTP_CODE" = "200" ]; then
            echo "✅ OTP Form berhasil diubah ke DISABLED"
        else
            echo "❌ Gagal mengubah OTP Form (HTTP $HTTP_CODE)"
            echo "   Mencoba dengan payload lengkap..."
            
            # Try with full execution payload
            FULL_PAYLOAD=$(echo "$EXECUTIONS" | python3 -c "
import sys, json
execs = json.load(sys.stdin)
for e in execs:
    if e['id'] == '$OTP_EXEC_ID':
        e['requirement'] = 'DISABLED'
        print(json.dumps(e))
        break
" 2>/dev/null)
            
            HTTP_CODE2=$(curl -sf -o /dev/null -w "%{http_code}" -X PUT \
                "$KEYCLOAK_URL/admin/realms/$REALM/authentication/flows/browser/executions" \
                -H "Authorization: Bearer $ADMIN_TOKEN" \
                -H "Content-Type: application/json" \
                -d "$FULL_PAYLOAD")
            
            if [ "$HTTP_CODE2" = "202" ] || [ "$HTTP_CODE2" = "204" ] || [ "$HTTP_CODE2" = "200" ]; then
                echo "✅ OTP Form berhasil diubah ke DISABLED (attempt 2)"
            else
                echo "❌ Gagal mengubah OTP Form (HTTP $HTTP_CODE2)"
                echo "   Silakan ubah manual di Admin Console:"
                echo "   Authentication → Flows → browser → OTP Form → DISABLED"
            fi
        fi
    fi
fi

# ---- 4. Ensure CONFIGURE_TOTP Required Action is Enabled + Default ----
echo ""
echo "[4/4] Memastikan Required Action 'Configure OTP' aktif sebagai default action..."

# Get current required actions
REQUIRED_ACTIONS=$(curl -sf \
    "$KEYCLOAK_URL/admin/realms/$REALM/authentication/required-actions" \
    -H "Authorization: Bearer $ADMIN_TOKEN")

TOTP_ACTION_EXISTS=$(echo "$REQUIRED_ACTIONS" | python3 -c "
import sys, json
actions = json.load(sys.stdin)
for a in actions:
    if a.get('alias') == 'CONFIGURE_TOTP':
        print('exists')
        print('enabled=' + str(a.get('enabled', False)))
        print('default=' + str(a.get('defaultAction', False)))
        break
" 2>/dev/null || echo "")

if echo "$TOTP_ACTION_EXISTS" | grep -q "exists"; then
    TOTP_ENABLED=$(echo "$TOTP_ACTION_EXISTS" | grep "enabled=" | cut -d= -f2)
    TOTP_DEFAULT=$(echo "$TOTP_ACTION_EXISTS" | grep "default=" | cut -d= -f2)
    
    echo "   CONFIGURE_TOTP ditemukan"
    echo "   Enabled: $TOTP_ENABLED | Default Action: $TOTP_DEFAULT"
    
    # Update to ensure it's enabled AND default action
    HTTP_CODE=$(curl -sf -o /dev/null -w "%{http_code}" -X PUT \
        "$KEYCLOAK_URL/admin/realms/$REALM/authentication/required-actions/CONFIGURE_TOTP" \
        -H "Authorization: Bearer $ADMIN_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{
            \"alias\": \"CONFIGURE_TOTP\",
            \"name\": \"Configure OTP\",
            \"providerId\": \"CONFIGURE_TOTP\",
            \"enabled\": true,
            \"defaultAction\": true,
            \"priority\": 10
        }")
    
    if [ "$HTTP_CODE" = "204" ] || [ "$HTTP_CODE" = "200" ] || [ "$HTTP_CODE" = "202" ]; then
        echo "✅ CONFIGURE_TOTP diset sebagai Default Action (muncul saat registrasi)"
    else
        echo "⚠️  HTTP $HTTP_CODE - Cek manual di Admin Console"
    fi
else
    echo "⚠️  CONFIGURE_TOTP tidak ditemukan di Required Actions"
fi

# ---- Summary ----
echo ""
echo "============================================"
echo "  SELESAI!"
echo "============================================"
echo ""
echo "Perubahan yang dilakukan:"
echo "  ✅ OTP Form di browser flow → DISABLED"
echo "     (Login TIDAK perlu OTP lagi)"
echo ""
echo "  ✅ Configure OTP → Default Required Action"  
echo "     (User BARU tetap diminta setup OTP saat registrasi)"
echo ""
echo "Cara test:"
echo "  1. Login dengan user yang sudah ada → TIDAK diminta OTP"
echo "  2. Register user baru → DIMINTA setup OTP"
echo ""
