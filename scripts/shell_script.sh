#!/usr/bin/env bash

SCRIPTS_DIR="$HOME/.dotfiles/scripts/"

selected=$(find "$SCRIPTS_DIR" -maxdepth 1 -type f -executable -printf '%f\n' | sort | fuzzel --dmenu --prompt "Run: ")

[ -n "$selected" ] && exec "$SCRIPTS_DIR/$selected"
