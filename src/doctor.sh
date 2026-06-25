#!/data/data/com.termux/files/usr/bin/bash

source "$(dirname "$0")/common.sh"

pass() {
    success "$1"
}

fail() {
    error "$1"
}

check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        pass "$1"
    else
        fail "$1"
    fi
}

echo "========== Butler Doctor =========="
echo

check_command git
check_command bash
check_command termux-x11
check_command pulseaudio
check_command dbus-daemon
check_command startxfce4

echo

if [ -d "$HOME/storage/shared" ]; then
    pass "Storage permission"
else
    fail "Storage permission"
fi

if [ -n "$DISPLAY" ]; then
    pass "DISPLAY = $DISPLAY"
else
    warn "DISPLAY not set (normal if desktop isn't running)"
fi

if pgrep -f termux.x11 >/dev/null; then
    pass "Termux:X11 running"
else
    fail "Termux:X11 not running"
fi

echo
echo "========== Done =========="
