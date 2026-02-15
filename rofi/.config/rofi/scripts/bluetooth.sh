#!/bin/bash
# Bluetooth manager using bluetoothctl + rofi

notify() {
    notify-send "Bluetooth" "$1" --icon=bluetooth
}

BT_STATUS=$(bluetoothctl show | grep "Powered" | awk '{print $2}')

MENU="󰂯  Toggle Bluetooth\n──────────────────"

if [ "$BT_STATUS" = "yes" ]; then
    # Get paired devices
    DEVICES=$(bluetoothctl devices | while read -r _ mac name; do
        CONNECTED=$(bluetoothctl info "$mac" | grep "Connected: yes")
        if [ -n "$CONNECTED" ]; then
            echo "󰂱  $name [$mac] (connected)"
        else
            echo "󰂰  $name [$mac]"
        fi
    done)

    SCAN="󰂰  Scan for new devices"
    [ -n "$DEVICES" ] && MENU="$MENU\n$DEVICES\n$SCAN" || MENU="$MENU\n$SCAN"
else
    MENU="$MENU\n  Bluetooth is off"
fi

CHOSEN=$(echo -e "$MENU" | rofi -dmenu \
    -p "󰂯 Bluetooth" \
    -theme ~/.config/rofi/catppuccin-mocha-list.rasi)

[ -z "$CHOSEN" ] && exit 0

case "$CHOSEN" in
    *"Toggle Bluetooth"*)
        if [ "$BT_STATUS" = "yes" ]; then
            bluetoothctl power off && notify "Bluetooth disabled"
        else
            bluetoothctl power on && notify "Bluetooth enabled"
        fi ;;
    *"Scan for new devices"*)
        notify "Scanning for 10 seconds..."
        bluetoothctl scan on &
        SCAN_PID=$!
        sleep 10
        kill $SCAN_PID
        bluetoothctl scan off
        exec "$0" ;;
    *"(connected)"*)
        MAC=$(echo "$CHOSEN" | grep -oP '([0-9A-F]{2}:){5}[0-9A-F]{2}')
        NAME=$(echo "$CHOSEN" | sed 's/.*  //' | sed 's/ \[.*//')
        bluetoothctl disconnect "$MAC" && notify "Disconnected from $NAME" ;;
    *)
        MAC=$(echo "$CHOSEN" | grep -oP '([0-9A-F]{2}:){5}[0-9A-F]{2}')
        NAME=$(echo "$CHOSEN" | sed 's/.*  //' | sed 's/ \[.*//')
        bluetoothctl connect "$MAC" && notify "Connected to $NAME" || notify "Failed to connect to $NAME" ;;
esac
