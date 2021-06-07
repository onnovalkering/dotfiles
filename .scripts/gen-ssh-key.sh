#!/usr/bin/env bash
set -euo pipefail

COMMENT="onnovalkering@users.noreply.github.com"
OUTPUT_KEYFILE=$HOME/.ssh/id_ed25519

# Generate SSH key.
ssh-keygen -t ed25519 -f $OUTPUT_KEYFILE -C $COMMENT

# Start the SSH agent in the background.
eval "$(ssh-agent -s)"

# Add the private key to the SSH agent.
ssh-add $OUTPUT_KEYFILE
