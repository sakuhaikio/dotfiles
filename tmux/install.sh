#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

ln -sf "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "Tmux dotfiles installed."
