#!/usr/bin/env bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

ln -sf "$SCRIPT_DIR/.inputrc" "$HOME/.inputrc"

echo "Readline configuration installed."
