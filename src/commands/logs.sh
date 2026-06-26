#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

LOG_DIR="$HOME/butler-desktop/logs"

if [ ! -d "$LOG_DIR" ]; then
    die "Log directory not found."
fi

case "$1" in
    ""|butler)
        LOGFILE="$LOG_DIR/butler.log"
        ;;
    xfce)
        LOGFILE="$LOG_DIR/xfce.log"
        ;;
    follow)
        tail -f "$LOG_DIR/butler.log"
        exit 0
        ;;
    xfce-follow)
        tail -f "$LOG_DIR/xfce.log"
        exit 0
        ;;
    *)
        die "Usage: butler logs [butler|xfce|follow|xfce-follow]"
        ;;
esac

if [ -f "$LOGFILE" ]; then
    cat "$LOGFILE"
else
    die "Log file not found."
fi
