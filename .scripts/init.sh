#!/usr/bin/env bash
set -euo pipefail

if [[ $PWD != $HOME ]]; then
    echo "The 'init.sh' script must be run from the home directory."
    exit 1
fi

shopt -s expand_aliases

source ~/.shell_aliases
source ~/.shell_functions

# Perform OS-specific initialization.
source ~/.scripts/init-$(lowercase `uname`).sh

# Install system-wide Python packages.
if exists pip3; then
    echo "[$(sdate)] – Starting Python init."
    pip3 install --upgrade pip 

    if [ -f ~/requirements.txt ]; then
        pip3 install -r ~/requirements.txt
    fi

    echo "[$(sdate)] – Finished Python init."
else 
    echo "[$(sdate)] – Skipping Python init."
fi

# Install Rust, including clippy and rustfmt.
if ! exists rustup; then
    echo "[$(sdate)] – Starting Rust init."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash /dev/stdin --no-modify-path

    rustup component add clippy
    rustup component add rustfmt
    echo "[$(sdate)] – Finished Rust init."
else 
    echo "[$(sdate)] – Skipping Rust init."
fi

# Remove unnecessary files (locally, not remotely).
rm -f ~/Brewfile ~/LICENSE ~/README.md ~/requirements.txt
git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin
