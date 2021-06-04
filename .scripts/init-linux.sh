#!/usr/bin/env bash
set -euo pipefail

# Install system dependencies.
sudo apt-get update && sudo apt install -y \
    python3 \
    python3-pip

