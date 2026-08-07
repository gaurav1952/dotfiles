#!/usr/bin/env bash

MONITOR="eDP-1"

# Order must match your circle_layout= list in config.conf
layouts=("tile" "scroller" "grid" "deck" "monocle" "center_tile" "vertical_tile" "vertical_scroller")

declare -A layout_names=(
  ["T"]="Tile"
  ["S"]="Scroller"
  ["G"]="Grid"
  ["K"]="Deck"
  ["M"]="Monocle"
  ["CT"]="Center Tile"
  ["VT"]="Vertical Tile"
  ["VS"]="Vertical Scroller"
)

declare -A full_to_symbol=(
  ["tile"]="T"
  ["scroller"]="S"
  ["grid"]="G"
  ["deck"]="K"
  ["monocle"]="M"
  ["center_tile"]="CT"
  ["vertical_tile"]="VT"
  ["vertical_scroller"]="VS"
)

# Get current layout symbol from the monitor's active tag
current_symbol=$(mmsg get monitor "$MONITOR" | jq -r '.layout_symbol')

# Find current index by matching symbol
current_index=-1
for i in "${!layouts[@]}"; do
  if [[ "${full_to_symbol[${layouts[$i]}]}" == "$current_symbol" ]]; then
    current_index=$i
    break
  fi
done

next_index=$(((current_index - 1 + ${#layouts[@]}) % ${#layouts[@]}))
next_layout="${layouts[$next_index]}"
next_symbol="${full_to_symbol[$next_layout]}"

mmsg dispatch setlayout,"$next_layout"

notify-send "Layout Changed" "${layout_names[$next_symbol]}" -i preferences-desktop-display -t 1500
