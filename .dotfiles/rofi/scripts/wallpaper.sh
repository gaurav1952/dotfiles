#!/usr/bin/env bash
# ~/.local/bin/wallpaper-picker
WALLPAPER_DIR="$HOME/Pictures/wallpapers"
TRANSITION_TYPE="wipe"       # wipe, wave, grow, outer, any, random, fade, left, right, top, bottom
TRANSITION_DURATION="1.5"
TRANSITION_FPS="60"
TRANSITION_ANGLE="30"        # 0 = Left to Right, 90 = Top to Bottom, 45 = Diagonal (wipe/wave only)

# ── Ensure swww-daemon is running ──────────────────────────────────────────
if ! swww query &>/dev/null; then
    swww-daemon &
    sleep 0.5   # wait for socket to be ready
fi

# ── Rofi wallpaper picker ──────────────────────────────────────────────────
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
CHOSEN=$(echo "$CHOSEN" | xargs)
WALLPAPER_PATH="$WALLPAPER_DIR/$CHOSEN"
[ ! -f "$WALLPAPER_PATH" ] && exit 0

# ── Apply wallpaper with transition ───────────────────────────────────────
swww img "$WALLPAPER_PATH" \
    --transition-type "$TRANSITION_TYPE" \
    --transition-duration "$TRANSITION_DURATION" \
    --transition-fps "$TRANSITION_FPS" \
    --transition-angle "$TRANSITION_ANGLE"

# ── Matugen — generate Material You colors ────────────────────────────────
matugen image "$WALLPAPER_PATH" --mode dark
sleep 0.8   # ensure all templates are written before reloading

# ── Reload apps ───────────────────────────────────────────────────────────
pkill -SIGUSR2 waybar
pkill swaync; swaync &
hyprctl reload
pkill -SIGUSR1 kitty 2>/dev/null

# ── Save last wallpaper ───────────────────────────────────────────────────
mkdir -p "$HOME/.config/swww"
echo "$WALLPAPER_PATH" > "$HOME/.config/swww/last_wallpaper"

notify-send "Wallpaper Changed" "$(basename "$WALLPAPER_PATH")" \
    -t 2000 \
    -i "$WALLPAPER_PATH"