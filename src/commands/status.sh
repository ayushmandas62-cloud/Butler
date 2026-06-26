#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$SCRIPT_DIR/../lib/common.sh"
source "$PROJECT_ROOT/src/config/desktop.conf"
DESKTOP_STATUS="Stopped"

if pgrep -x openbox >/dev/null && pgrep -x polybar >/dev/null; then
    DESKTOP_STATUS="Running"
fi

echo "========== Butler Desktop =========="
echo

printf "%-15s : %s\n" "Desktop" "$DESKTOP_STATUS"
printf "%-15s : %s\n" "WM" "$WM"
printf "%-15s : %s\n" "BAR" "$BAR"
printf "%-15s : %s\n" "LAUNCHER" "$LAUNCHER"
printf "%-15s : %s\n" "DISPLAY" "$DISPLAY"
echo

echo

if pgrep -f "termux.x11" >/dev/null; then
    echo "Termux:X11     : Running"
else
    echo "Termux:X11     : Stopped"
fi

if pgrep -x openbox >/dev/null; then
    echo "Openbox        : Running"
else
    echo "Openbox        : Stopped"
fi

if pgrep -x polybar >/dev/null; then
    echo "Polybar        : Running"
else
    echo "Polybar        : Stopped"
fi

echo
echo "===================================="
