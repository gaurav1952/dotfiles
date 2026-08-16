#!/bin/bash
PIDFILE="/tmp/wlsunset.pid"
if [ -f "$PIDFILE" ] && kill -0 "$(cat $PIDFILE)" 2>/dev/null; then
    echo true
else
    echo false
fi
