#!/usr/bin/env bash
set -euo pipefail

if [[ $PWD != $HOME ]]; then
    echo "The 'init.sh' script must be run from the home directory."
    exit 1
fi

# Perform OS-specific initialization.
source ~/.shell_functions
source ~/.scripts/init-$(lowercase `uname`).sh

# Install system-wide Python packages.
if [ -f ~/requirements.txt ]; then
    pip3 install -r ~/requirements.txt
fi

# Remove unnecessary files (locally, not remotely).
rm -f ~/Brewfile ~/LICENSE ~/README.md ~/requirements.txt
git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin
