#!/bin/bash
# Dotfiles picker - opens selected config folder in vscodium

DOTFILES_DIR="$HOME/.dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    notify-send "Dotfiles" "Directory $DOTFILES_DIR not found!"
    exit 1
fi

# List all top-level directories (each is a stow package)
CONFIGS=$(find "$DOTFILES_DIR" -maxdepth 1 -mindepth 1 -type d ! -name '.git' -printf "%f\n" | sort)

if [ -z "$CONFIGS" ]; then
    notify-send "Dotfiles" "No configs found in $DOTFILES_DIR"
    exit 1
fi

CHOSEN=$(echo "$CONFIGS" | rofi -dmenu \
    -p "󰘓 Dotfiles" \
    -theme ~/.config/rofi/catppuccin-mocha-list.rasi \
    -i)

[ -z "$CHOSEN" ] && exit 0

CONFIG_PATH="$DOTFILES_DIR/$CHOSEN"

# Open in vscodium
vscodium "$CONFIG_PATH" &
