#!/usr/bin/env bash

set -euo pipefail

serviceName="ufw.service"

# Abort if ufw is not installed.
if ! systemctl --all --type service | grep -q "$serviceName"; then
    echo "The $serviceName does NOT exist. Please install ufw."
    exit 1
fi

# Start with a clean slate.
sudo ufw reset

# By default, block ALL incoming and allow ALL outgoing connections.
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Only allow SSH (6 connections per 30 seconds).
sudo ufw allow ssh
sudo ufw limit ssh

# Apply changes.
sudo ufw reload

# Enable and show current status.
sudo ufw enable
sudo ufw status verbose