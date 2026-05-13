#!/bin/bash

# Check if xray is already running to avoid port conflicts in multiple terminal tabs
if pgrep -f "/usr/local/bin/xray" > /dev/null
then
    # Extract the current UUID being used
    UUID=$(grep -o '"id": "[^"]*"' /tmp/config.json | cut -d'"' -f4 | head -1)
    DATE_REMARK=$(date +"%Y%m%d-%H%M")
    
    echo -e "\n=================================================="
    echo "🚀 GHTUN WARZONE (Already Running)"
    echo "=================================================="
    
    echo -e "\n🔗 Domain Address Configuration:"
    echo "vless://${UUID}@${CODESPACE_NAME}-443.app.github.dev:443?encryption=none&security=tls&sni=${CODESPACE_NAME}-443.app.github.dev&insecure=0&allowInsecure=0&type=ws&path=%2Flive-chat#ghtun-${DATE_REMARK}"
    
    echo -e "\n🔗 IP Address Configurations (Lower Ping):"
    IPS=("50.7.87.4" "50.7.87.2" "142.54.178.211" "50.7.87.5" "204.12.196.34")
    for IP in "${IPS[@]}"; do
        echo "vless://${UUID}@${IP}:443?encryption=none&security=tls&sni=${CODESPACE_NAME}-443.app.github.dev&insecure=0&allowInsecure=0&type=ws&path=%2Flive-chat#ghtun-${DATE_REMARK}"
    done
    
    echo -e "\n=================================================="
    echo "⚡ Xray Service is already active in another terminal."
    echo -e "==================================================\n"
else
    # Generate new UUID for a fresh start
    UUID=$(uuidgen)
    
    # Update config.json with the new UUID
    sed -E "s/\"id\": \"[^\"]+\"/\"id\": \"${UUID}\"/" /etc/config.json > /tmp/config.json
    
    # Make port public quietly
    if command -v gh &> /dev/null; then
        gh codespace ports visibility 443:public -c $CODESPACE_NAME >/dev/null 2>&1
    fi
    
    # Date for remark
    DATE_REMARK=$(date +"%Y%m%d-%H%M")
    
    echo -e "\n=================================================="
    echo "🚀 GHTUN UPDATE FOR WARZONE"
    echo "=================================================="
    
    echo -e "\n🔗 Domain Address Configuration:"
    echo "vless://${UUID}@${CODESPACE_NAME}-443.app.github.dev:443?encryption=none&security=tls&sni=${CODESPACE_NAME}-443.app.github.dev&insecure=0&allowInsecure=0&type=ws&path=%2Flive-chat#ghtun-${DATE_REMARK}"
    
    echo -e "\n🔗 IP Address Configurations (Lower Ping):"
    IPS=("50.7.87.4" "50.7.87.2" "142.54.178.211" "50.7.87.5" "204.12.196.34")
    for IP in "${IPS[@]}"; do
        echo "vless://${UUID}@${IP}:443?encryption=none&security=tls&sni=${CODESPACE_NAME}-443.app.github.dev&insecure=0&allowInsecure=0&type=ws&path=%2Flive-chat#ghtun-${DATE_REMARK}"
    done
    
    echo -e "\n=================================================="
    echo "⚡ Starting Xray Service..."
    echo -e "==================================================\n"
    
    # Run xray in background
    nohup /usr/local/bin/xray -c /tmp/config.json > /tmp/xray.log 2>&1 &
fi
