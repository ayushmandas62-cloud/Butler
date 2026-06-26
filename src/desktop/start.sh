#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/desktop.conf"

export DISPLAY="$DISPLAY"

# Start Termux:X11 only if not running
pgrep -f "termux.x11" >/dev/null || {
    termux-x11 "$DISPLAY" >/dev/null 2>&1 &
    sleep 2
}

# Start Window Manager
case "$WM" in
    openbox)
        pgrep -x openbox >/dev/null || openbox &
        ;;
esac

# Start Bar
case "$BAR" in
    polybar)
        pgrep -x polybar >/dev/null || polybar main &
        ;;
esac
