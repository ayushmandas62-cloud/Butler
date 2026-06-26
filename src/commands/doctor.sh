#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"
source "$SCRIPT_DIR/../lib/runtime.sh"
source "$SCRIPT_DIR/../lib/storage.sh"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/desktop.conf"
pass() {
    success "$1"
}

fail() {
    error "$1"
}

check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        pass "$1 installed"
    else
        fail "$1 missing"
    fi
}

check_process() {
    if pgrep -f "$1" >/dev/null 2>&1; then
        pass "$2 running"
    else
        fail "$2 not running"
    fi
}

init_runtime

echo "========== Butler Doctor =========="
echo

echo "Installed Components"
echo "--------------------"

check_command git
check_command bash
check_command termux-x11
check_command openbox
check_command polybar
check_command picom
check_command rofi
check_command thunar

echo

echo "Storage"
echo "-------"

if check_storage >/dev/null 2>&1; then
    pass "Storage permission"
else
    fail "Storage permission"
fi

echo

echo "Desktop"
echo "-------"

echo "Profile : ${WM:-unknown}"
echo "Display : ${DISPLAY:-:0}"

echo

echo "Running Services"
echo "----------------"

check_process "termux.x11" "Termux:X11"
check_process "openbox" "Openbox"
check_process "polybar" "Polybar"
check_process "picom" "Picom"

echo
echo "=============================="
