#!/usr/bin/env bash

set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <name> <email>"
    echo
    echo "Example:"
    echo "  $0 \"John Doe\" \"john.doe@example.com\""
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

cp "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"

git config --global user.name "$1"
git config --global user.email "$2"

echo "Git configuration installed successfully."
