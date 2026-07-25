#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

ln -sf "$SCRIPT_DIR/.bash_aliases"   "$HOME/.bash_aliases"
ln -sf "$SCRIPT_DIR/.bash_exports"   "$HOME/.bash_exports"
ln -sf "$SCRIPT_DIR/.bash_functions" "$HOME/.bash_functions"
ln -sf "$SCRIPT_DIR/.bash_plugins"   "$HOME/.bash_plugins"

echo "Dotfiles installed."
