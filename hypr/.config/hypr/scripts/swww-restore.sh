#!/bin/bash
# Restore last wallpaper on login

LAST_WALLPAPER="$HOME/.config/swww/last_wallpaper"
DEFAULT_WALLPAPER="$HOME/Pictures/wallpaper/flatppuccin.png"

# Wait for swww daemon
swww-daemon &
sleep 0.5

if [ -f "$LAST_WALLPAPER" ]; then
    WALLPAPER=$(cat "$LAST_WALLPAPER")
    if [ -f "$WALLPAPER" ]; then
        swww img "$WALLPAPER" --transition-type fade --transition-duration 1
        exit 0
    fi
fi

# Fallback to default
swww img "$DEFAULT_WALLPAPER" --transition-type fade --transition-duration 1