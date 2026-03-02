#!/bin/bash
# Clipboard manager using cliphist + rofi
# Images are supported via cliphist

cliphist list | rofi -dmenu \
    -p "󰅍 Clipboard" \
    -theme ~/.config/rofi/theme-list.rasi \
    | cliphist decode | wl-copy
