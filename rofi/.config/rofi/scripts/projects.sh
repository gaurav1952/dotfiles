#!/bin/bash
# Project picker - opens selected project in kitty at that path

PROJECTS_DIR="$HOME/Projects"

if [ ! -d "$PROJECTS_DIR" ]; then
    notify-send "Projects" "Directory $PROJECTS_DIR not found!"
    exit 1
fi

# List all directories in ~/Projects
PROJECTS=$(find "$PROJECTS_DIR" -maxdepth 1 -mindepth 1 -type d -printf "%f\n" | sort)

if [ -z "$PROJECTS" ]; then
    notify-send "Projects" "No projects found in $PROJECTS_DIR"
    exit 1
fi

CHOSEN=$(echo "$PROJECTS" | rofi -dmenu \
    -p " Projects" \
    -theme ~/.config/rofi/catppuccin-mocha-list.rasi \
    -i)

[ -z "$CHOSEN" ] && exit 0

PROJECT_PATH="$PROJECTS_DIR/$CHOSEN"

# Open kitty at the project path
kitty --directory "$PROJECT_PATH" &
