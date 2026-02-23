#!/bin/bash
echo "Testing localhost..."
curl -s -m 2 -I http://localhost:3000 | head -n 1
curl -s -m 2 -I http://localhost:5000 | head -n 1
curl -s -m 2 -I http://localhost:8080 | head -n 1

echo -e "\nTesting LAN IP (192.168.137.97)..."
curl -s -m 2 -I http://192.168.137.97:3000 | head -n 1
curl -s -m 2 -I http://192.168.137.97:5000 | head -n 1
curl -s -m 2 -I http://192.168.137.97:8080 | head -n 1

echo -e "\nChecking listening ports..."
lsof -i -P -n | grep -E 'LISTEN' | grep -E '(3000|5000|8080)'
