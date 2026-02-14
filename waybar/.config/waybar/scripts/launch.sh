#!/usr/bin/env bash

pkill -9 waybar 2>/dev/null

sleep 0.2

waybar >/dev/null 2>&1 &