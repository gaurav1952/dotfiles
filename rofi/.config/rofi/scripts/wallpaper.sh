#!/bin/bash
# Wallpaper picker using rofi dmenu + swww

WALLPAPER_DIR="$HOME/Pictures/wallpaper"

# Transition settings — edit these to change effect!
# Types: fade, wipe, wave, grow, outer, random
TRANSITION_TYPE="random"
TRANSITION_DURATION="1.5"
TRANSITION_FPS="60"
TRANSITION_ANGLE="30"  # 0 = Left to Right , 90 = Top to Bottom 45 = Diagonal. Only in wipe and wave 

# Make sure swww daemon is running
swww query 2>/dev/null || (swww-daemon & sleep 0.5)

# Build list with absolute paths as icons
CHOSEN=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \
    \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) \
    | sort \
    | while IFS= read -r file; do
        name=$(basename "$file")
        printf "%s\0icon\x1f%s\n" "$name" "$file"
    done \
    | rofi -dmenu \
        -p "󰸉 Wallpaper" \
        -theme ~/.config/rofi/wallpaper.rasi \
        -show-icons \
        -no-custom \
        -i)

[ -z "$CHOSEN" ] && exit 0

# Strip any trailing whitespace
CHOSEN=$(echo "$CHOSEN" | xargs)

WALLPAPER_PATH="$WALLPAPER_DIR/$CHOSEN"

[ ! -f "$WALLPAPER_PATH" ] && exit 0

# Apply wallpaper
swww img "$WALLPAPER_PATH" \
    --transition-type "$TRANSITION_TYPE" \
    --transition-duration "$TRANSITION_DURATION" \
    --transition-fps "$TRANSITION_FPS" \
    --transition-angle "$TRANSITION_ANGLE"

# Save last wallpaper
mkdir -p "$HOME/.config/swww"
echo "$WALLPAPER_PATH" > "$HOME/.config/swww/last_wallpaper"

notify-send "Wallpaper Changed" "$(basename "$WALLPAPER_PATH")" -t 2000