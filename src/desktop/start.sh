#!/data/data/com.termux/files/usr/bin/bash

export DISPLAY=:0

# Start Termux:X11 only if not running
pgrep -f "termux.x11" >/dev/null || {
    termux-x11 :0 >/dev/null 2>&1 &
    sleep 2
}

# Start Openbox only if not running
pgrep -x openbox >/dev/null || openbox &

# Start Polybar only if not running
pgrep -x polybar >/dev/null || polybar main &
