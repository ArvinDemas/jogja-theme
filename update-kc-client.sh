#!/bin/bash
set -e
KEYCLOAK_URL="http://localhost:8080"
REALM="PemdaSSO"
CLIENT_ID="pemda-dashboard"
CURRENT_IP="192.168.100.142"
BACKEND_ENV="/Users/mrnugroho/Downloads/pemda-dashboard-react/backend/.env"

# Wait for KC
until curl -sf "$KEYCLOAK_URL/realms/$REALM" > /dev/null; do
    echo "Waiting for Keycloak..."
    sleep 2
done

KC_SECRET=$(grep "KEYCLOAK_CLIENT_SECRET" "$BACKEND_ENV" | cut -d'=' -f2 | tr -d ' ' | tr -d '\r')
echo "KC_SECRET: $KC_SECRET"

ADMIN_TOKEN=$(curl -sf -X POST \
    "$KEYCLOAK_URL/realms/master/protocol/openid-connect/token" \
    -d "grant_type=password" \
    -d "client_id=admin-cli" \
    -d "username=admin" \
    -d "password=admin" \
    | python3 -c "import sys,json; print(json.load(sys.stdin).get('access_token', ''))" 2>/dev/null || echo "")

if [ -z "$ADMIN_TOKEN" ]; then
    echo "Failed to get admin token"
    exit 1
fi

CLIENT_UUID=$(curl -sf \
    "$KEYCLOAK_URL/admin/realms/$REALM/clients?clientId=$CLIENT_ID" \
    -H "Authorization: Bearer $ADMIN_TOKEN" \
    | python3 -c "import sys,json; data=json.load(sys.stdin); print(data[0]['id'] if data else '')" 2>/dev/null || echo "")

if [ -z "$CLIENT_UUID" ]; then
    echo "Failed to get client UUID"
    exit 1
fi

echo "Updating client $CLIENT_UUID..."
curl -sf -o /dev/null -w "%{http_code}\n" -X PUT \
    "$KEYCLOAK_URL/admin/realms/$REALM/clients/$CLIENT_UUID" \
    -H "Authorization: Bearer $ADMIN_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"clientId\": \"$CLIENT_ID\",
        \"rootUrl\": \"http://${CURRENT_IP}:3000\",
        \"redirectUris\": [\"http://${CURRENT_IP}:3000/*\"],
        \"webOrigins\": [\"http://${CURRENT_IP}:3000\"],
        \"attributes\": {
            \"post.logout.redirect.uris\": \"http://${CURRENT_IP}:3000/*\"
        }
    }"

echo "Done"
