#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/desktop.conf"

export DISPLAY="${DISPLAY:-:0}"

pgrep -x openbox >/dev/null || openbox &
sleep 1

pgrep -x polybar >/dev/null || polybar main &
sleep 1

"$SCRIPT_DIR/picom.sh"

pgrep -x rofi >/dev/null || true
