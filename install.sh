#!/usr/bin/env bash

set -e

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

ln -sf "$DOTFILES/bash/.bash_aliases"   "$HOME/.bash_aliases"
ln -sf "$DOTFILES/bash/.bash_exports"   "$HOME/.bash_exports"
ln -sf "$DOTFILES/bash/.bash_functions" "$HOME/.bash_functions"
ln -sf "$DOTFILES/bash/.bash_plugins"   "$HOME/.bash_plugins"

ln -sf "$DOTFILES/readline/.inputrc"    "$HOME/.inputrc"

echo "Dotfiles installed."
