#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$SCRIPT_DIR/../lib/common.sh"

CONFIG_FILE="$PROJECT_ROOT/src/config/desktop.conf"

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

echo "========== Butler Desktop Configuration =========="
echo

printf "%-15s : %s\n" "WM" "$WM"
printf "%-15s : %s\n" "BAR" "$BAR"
printf "%-15s : %s\n" "LAUNCHER" "$LAUNCHER"
printf "%-15s : %s\n" "FILE_MANAGER" "$FILE_MANAGER"
printf "%-15s : %s\n" "COMPOSITOR" "$COMPOSITOR"
printf "%-15s : %s\n" "WALLPAPER" "$WALLPAPER"
printf "%-15s : %s\n" "DISPLAY" "$DISPLAY"

echo
echo "=============================================="
