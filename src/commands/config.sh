#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

CONFIG_FILE="$HOME/butler-desktop/configs/butler.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    die "Configuration file not found."
fi

source "$CONFIG_FILE"

case "$1" in
    get)
        if [ -z "$2" ]; then
            die "Usage: butler config get <KEY>"
        fi

        eval "echo \${$2}"
        exit 0
        ;;

    set)
        if [ $# -ne 3 ]; then
            die "Usage: butler config set <KEY> <VALUE>"
        fi

        sed -i "s|^$2=.*|$2=$3|" "$CONFIG_FILE"

        success "$2 updated to $3"
        exit 0
        ;;
esac

echo "========== Butler Configuration =========="
echo

echo "DISPLAY            : $DISPLAY"
echo "DESKTOP            : $DESKTOP"
echo "ENABLE_DBUS        : $ENABLE_DBUS"
echo "ENABLE_X11         : $ENABLE_X11"
echo "MONITOR_INTERVAL   : $MONITOR_INTERVAL"
echo "RUNTIME_DIR        : $RUNTIME_DIR"
echo "LOG_DIR            : $LOG_DIR"

echo
echo "=========================================="
