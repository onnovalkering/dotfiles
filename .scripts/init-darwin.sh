#!/usr/bin/env bash
set -euo pipefail

if [[ $PWD != $HOME ]]; then
    echo "The 'init-darwin.sh' script must be run from the home directory."
    exit 1
fi

# Install Homebrew.
if [[ ! exists brew ]]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -f Brewfile ]]; then
    brew bundle
fi