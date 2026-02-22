#!/bin/bash
PIDFILE="/tmp/wlsunset.pid"
if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
    kill "$(cat $PIDFILE)"
    rm "$PIDFILE"
    notify-send "Blue Light Filter" "OFF" --icon=display-brightness-symbolic
else
    wlsunset -t 4500 -T 4501 &
    echo $! > "$PIDFILE"
    notify-send "Blue Light Filter" "ON (4500K)" --icon=display-brightness-symbolic
fi
