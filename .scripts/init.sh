#!/usr/bin/env bash
set -euo pipefail

source $HOME/.shell_functions

# Perform OS-specific initialization.
source $HOME/.scripts/init-$(lowercase `uname`).sh

# Remove unnecessary files (locally).
rm $HOME/LICENSE
rm $HOME/README.md
rm $HOME/requirements.txt

git ls-files --deleted -z | git update-index --assume-unchanged -z --stdin