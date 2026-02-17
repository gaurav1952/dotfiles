#!/bin/bash
# WiFi selector using nmcli + rofi

notify() {
    notify-send "WiFi" "$1" --icon=network-wireless
}

# Check current wifi state
WIFI_STATE=$(nmcli radio wifi)

if [ "$WIFI_STATE" = "disabled" ]; then
    CHOSEN=$(echo -e "󰖩  Enable WiFi" | rofi -dmenu \
        -p "󰖪 WiFi Off" \
        -theme ~/.config/rofi/catppuccin-mocha-list.rasi)
    [ -z "$CHOSEN" ] && exit 0
    nmcli radio wifi on && notify "WiFi enabled" && sleep 2 && exec "$0"
    exit 0
fi

# Rescan
nmcli device wifi rescan 2>/dev/null

# Get connected SSID
CONNECTED=$(nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes:' | cut -d: -f2-)

# Build network list
NETWORKS=$(nmcli -t -f IN-USE,SSID,SECURITY,SIGNAL dev wifi list 2>/dev/null \
    | while IFS=: read -r inuse ssid security signal; do
        [ -z "$ssid" ] || [ "$ssid" = "--" ] && continue
        if [ "$inuse" = "*" ]; then
            echo "󰖩  $ssid  $security  ${signal}%  ✓ connected"
        else
            echo "   $ssid  $security  ${signal}%"
        fi
    done | awk '!seen[$0]++')

MENU="󰖪  Disable WiFi\n󰑓  Rescan Networks\n󰌾  Forget a Network\n─────────────────────────────────────\n$NETWORKS"

CHOSEN=$(echo -e "$MENU" | rofi -dmenu \
    -p "󰖩 WiFi" \
    -theme ~/.config/rofi/catppuccin-mocha-list.rasi)

[ -z "$CHOSEN" ] && exit 0

case "$CHOSEN" in
    *"Disable WiFi"*)
        nmcli radio wifi off && notify "WiFi disabled" ;;

    *"Rescan Networks"*)
        notify "Rescanning..."
        nmcli device wifi rescan
        sleep 2
        exec "$0" ;;

    *"Forget a Network"*)
        # Show only saved wifi connections
        SAVED=$(nmcli -t -f NAME,TYPE connection show \
            | grep ':802-11-wireless$' \
            | cut -d: -f1)

        [ -z "$SAVED" ] && notify "No saved networks found" && exit 0

        TO_FORGET=$(echo "$SAVED" | rofi -dmenu \
            -p "󰌾 Forget which network?" \
            -theme ~/.config/rofi/catppuccin-mocha-list.rasi)

        [ -z "$TO_FORGET" ] && exit 0

        nmcli connection delete "$TO_FORGET" \
            && notify "Forgot $TO_FORGET" \
            || notify "Failed to forget $TO_FORGET" ;;

    *"connected"*)
        notify "Already connected to $CONNECTED" ;;

    *)
        SSID=$(echo "$CHOSEN" | sed 's/^[[:space:]]*//' | sed 's/^󰖩  //' | sed 's/^   //' | awk '{
            for(i=1;i<=NF;i++){
                if($i~/^WPA|^WEP|^--$/){break}
                printf "%s ",$i
            }
        }' | xargs)

        [ -z "$SSID" ] && exit 0

        SAVED=$(nmcli -t -f NAME connection show | grep -Fx "$SSID")

        if [ -n "$SAVED" ]; then
            nmcli connection up "$SSID" \
                && notify "Connected to $SSID" \
                || notify "Failed to connect to $SSID"
        else
            PASS=$(rofi -dmenu \
                -p "󰌾 Password for $SSID" \
                -theme ~/.config/rofi/catppuccin-mocha-list.rasi \
                -password)
            [ -z "$PASS" ] && exit 0
            nmcli device wifi connect "$SSID" password "$PASS" \
                && notify "Connected to $SSID" \
                || notify "Failed to connect to $SSID"
        fi ;;
esac