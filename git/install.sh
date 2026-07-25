#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_CONFIG="$SCRIPT_DIR/.gitconfig"
TARGET_CONFIG="$HOME/.gitconfig"
BACKUP_CONFIG="$HOME/.gitconfig.backup"

if [[ ! -f "$SOURCE_CONFIG" ]]; then
    echo "Error: configuration file not found:"
    echo "  $SOURCE_CONFIG"
    exit 1
fi

# Read the existing global Git identity before replacing .gitconfig.
user_name="$(git config --global --get user.name || true)"
user_email="$(git config --global --get user.email || true)"

if [[ -z "$user_name" || -z "$user_email" ]]; then
    echo "Error: existing Git user information was not found."
    echo
    echo "Configure it first with:"
    echo '  git config --global user.name "John Doe"'
    echo '  git config --global user.email "john.doe@example.com"'
    exit 1
fi

# Preserve the previous configuration as a backup.
if [[ -f "$TARGET_CONFIG" ]]; then
    cp -- "$TARGET_CONFIG" "$BACKUP_CONFIG"
    echo "Previous configuration backed up to:"
    echo "  $BACKUP_CONFIG"
fi

# Install the repository's Git configuration.
cp -- "$SOURCE_CONFIG" "$TARGET_CONFIG"

# Restore the existing user identity.
git config --global user.name "$user_name"
git config --global user.email "$user_email"

echo
echo "Git configuration installed successfully."
echo "User:  $user_name"
echo "Email: $user_email"
