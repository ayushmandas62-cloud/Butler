#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/desktop.conf"
source "$PROJECT_ROOT/src/lib/desktop.sh"

clear

echo "=========================================="
echo "           BUTLER CONTROL CENTER"
echo "=========================================="
echo

printf "%-18s %s\n" "Desktop" "$WM"
printf "%-18s %s\n" "Bar" "$BAR"
printf "%-18s %s\n" "Launcher" "$LAUNCHER"
printf "%-18s %s\n" "Display" "$DISPLAY"

echo

if desktop_running; then
    printf "%-18s %s\n" "Desktop Status" "Running"
else
    printf "%-18s %s\n" "Desktop Status" "Stopped"
fi

if x11_running; then
    printf "%-18s %s\n" "Termux:X11" "Running"
else
    printf "%-18s %s\n" "Termux:X11" "Stopped"
fi

echo
echo "System"
echo "------"

printf "%-18s %s\n" "Android" "$(getprop ro.build.version.release)"
printf "%-18s %s\n" "Architecture" "$(uname -m)"
printf "%-18s %s\n" "Kernel" "$(uname -r)"

MEM=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
printf "%-18s %s\n" "Memory" "$MEM"

STORAGE=$(df -h "$HOME" | awk 'NR==2 {print $3 "/" $2}')
printf "%-18s %s\n" "Storage" "$STORAGE"

echo
echo "=========================================="
