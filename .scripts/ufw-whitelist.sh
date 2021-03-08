#!/usr/bin/env bash

set -euo pipefail

serviceName="ufw.service"

# Abort if ufw is not installed.
if ! systemctl --all --type service | grep -q "$serviceName"; then
    echo "The $serviceName does NOT exist. Please install ufw."
    exit 1
fi

PROTOCOL="${1,,}"
IP_ADDR="${2}"
PORT="${3}"

# A whitelist contains: protocol, IP address, and port
sudo ufw allow \
    proto $PROTOCOL \
    from $IP_ADDR \
    to any port $PORT

# Apply changes.
sudo ufw reload

# Show current status.
sudo ufw status verbose