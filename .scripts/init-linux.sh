#!/usr/bin/env bash
set -euo pipefail

# Install system dependencies.
sudo apt-get update && sudo apt install -y \
    python3-pip

# Add CAP_NET_RAW capability to Python (required by automation tool).
sudo setcap cap_net_raw+ep $(readlink -f $(command -v python3))