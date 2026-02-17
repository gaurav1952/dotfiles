#!/bin/bash
# Only toggles, never checks state
PIDFILE="/tmp/hyprsunset.pid"
if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
    kill "$(cat $PIDFILE)"
    rm "$PIDFILE"
    notify-send "Hyprsunset" "Blue light filter OFF" --icon=display-brightness-symbolic
else
    hyprsunset -t 4500 &
    echo $! > "$PIDFILE"
    notify-send "Hyprsunset" "Blue light filter ON (4500K)" --icon=display-brightness-symbolic
fi