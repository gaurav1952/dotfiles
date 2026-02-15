#!/bin/bash
# WiFi selector using nmcli + rofi

notify() {
    notify-send "WiFi" "$1" --icon=network-wireless
}

# Scan for networks
NETWORKS=$(nmcli -f SSID,SECURITY,SIGNAL device wifi list 2>/dev/null | tail -n +2 | \
    awk '{printf "%-35s %-15s %s%%\n", $1, $2, $3}' | sort -t'%' -k1 -rn | uniq)

if [ -z "$NETWORKS" ]; then
    notify "No networks found. Make sure WiFi is enabled."
    exit 1
fi

# Add options at top
OPTIONS="󰖩  Enable WiFi\n󰖪  Disable WiFi\n󰑓  Rescan\n──────────────────\n$NETWORKS"

CHOSEN=$(echo -e "$OPTIONS" | rofi -dmenu \
    -p "󰖩 WiFi" \
    -theme ~/.config/rofi/catppuccin-mocha-list.rasi)

[ -z "$CHOSEN" ] && exit 0

case "$CHOSEN" in
    *"Enable WiFi"*)
        nmcli radio wifi on && notify "WiFi enabled" ;;
    *"Disable WiFi"*)
        nmcli radio wifi off && notify "WiFi disabled" ;;
    *"Rescan"*)
        nmcli device wifi rescan && notify "Rescanning..." && exec "$0" ;;
    *)
        SSID=$(echo "$CHOSEN" | awk '{print $1}')
        # Check if already saved
        SAVED=$(nmcli -f NAME connection show | grep -w "$SSID")
        if [ -n "$SAVED" ]; then
            nmcli connection up "$SSID" && notify "Connected to $SSID"
        else
            # Ask for password
            PASS=$(rofi -dmenu \
                -p "󰌾 Password for $SSID" \
                -theme ~/.config/rofi/catppuccin-mocha-list.rasi \
                -password)
            if [ -n "$PASS" ]; then
                nmcli device wifi connect "$SSID" password "$PASS" && notify "Connected to $SSID" || notify "Failed to connect to $SSID"
            fi
        fi ;;
esac
