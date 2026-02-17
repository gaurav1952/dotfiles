#!/bin/bash
# Only checks state, never toggles
PIDFILE="/tmp/hyprsunset.pid"
if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
    echo true
else
    echo false
fi