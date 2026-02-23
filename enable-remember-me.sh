#!/bin/bash
# =============================================================================
# Enable Remember Me — Keycloak Realm Configuration
# =============================================================================
# Enables "Remember Me" feature in Keycloak so users who check the checkbox
# get a 30-day SSO session. This means they won't need OTP again on the
# same browser/device for 30 days.
# =============================================================================
set -e

KEYCLOAK_URL="${KEYCLOAK_URL:-http://localhost:8080}"
REALM="${REALM:-PemdaSSO}"
ADMIN_USER="${ADMIN_USER:-admin}"
ADMIN_PASS="${ADMIN_PASS:-admin}"

echo "============================================"
echo "  Enable Remember Me (30 hari)"
echo "============================================"
echo ""

# 1. Get Admin Token
echo "[1/2] Mendapatkan admin token..."
TOKEN=$(curl -s -X POST "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=$ADMIN_USER&password=$ADMIN_PASS&grant_type=password&client_id=admin-cli" \
  | python3 -c "import sys,json; print(json.load(sys.stdin)['access_token'])" 2>/dev/null || echo "")

if [ -z "$TOKEN" ]; then
    echo "❌ Gagal mendapatkan admin token. Pastikan Keycloak berjalan."
    exit 1
fi
echo "✅ Admin token berhasil"

# 2. Enable Remember Me + set session timeouts
echo ""
echo "[2/2] Mengaktifkan Remember Me dengan sesi 30 hari..."
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" -X PUT "$KEYCLOAK_URL/admin/realms/$REALM" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "rememberMe": true,
    "ssoSessionMaxLifespan": 2592000,
    "ssoSessionMaxLifespanRememberMe": 2592000,
    "ssoSessionIdleTimeout": 1800,
    "ssoSessionIdleTimeoutRememberMe": 2592000
  }')

if [ "$HTTP_CODE" = "204" ] || [ "$HTTP_CODE" = "200" ]; then
    echo "✅ Remember Me berhasil diaktifkan!"
else
    echo "❌ Gagal (HTTP $HTTP_CODE)"
    exit 1
fi

echo ""
echo "============================================"
echo "  KONFIGURASI SELESAI"
echo "============================================"
echo ""
echo "  ✅ Remember Me: AKTIF"
echo "  ✅ Sesi normal idle: 30 menit"
echo "  ✅ Sesi Remember Me: 30 hari"
echo ""
echo "  Checkbox 'Ingat Saya' akan muncul di halaman login."
echo "  User yang centang checkbox tidak perlu OTP lagi"
echo "  di browser/perangkat yang sama selama 30 hari."
echo ""
