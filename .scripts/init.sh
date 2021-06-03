#!/usr/bin/env bash
set -euo pipefail

source ~/.shell_functions

# Perform OS-specific initialization.
source ~/.scripts/init-$(lowercase `uname`).sh

# Install system-wide Python packages.
if [ -f ~/requirements.txt ]; then
    pip3 install -r ~/requirements.txt
fi

# Remove unnecessary files (locally).
rm -f ~/LICENSE ~/README.md ~/requirements.txt
git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin
