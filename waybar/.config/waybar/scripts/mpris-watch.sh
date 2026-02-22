#!/bin/bash

playerctl --follow metadata --format '{{status}}' 2>/dev/null | while read -r _; do
    pkill -RTMIN+5 waybar
done