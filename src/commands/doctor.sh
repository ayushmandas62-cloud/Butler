#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"
source "$SCRIPT_DIR/../lib/runtime.sh"
source "$SCRIPT_DIR/../lib/storage.sh"

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

init_runtime

echo "Butler Doctor"
echo "=============="
echo

check_command git
check_command bash
check_command termux-x11
check_command pulseaudio
check_command dbus-daemon
check_command startxfce4

echo

if check_storage >/dev/null 2>&1; then
    pass "Storage permission"
else
    fail "Storage permission"
fi

if service_running xfce; then
    pass "DISPLAY = ${DISPLAY:-:0}"
else
    info "DISPLAY not active (desktop not running)"
fi

echo
echo "Running services"

if service_running xfce; then
    pass "Desktop running"
else
    fail "Desktop not running"
fi

if service_running dbus; then
    pass "D-Bus running"
else
    fail "D-Bus not running"
fi

if service_running x11; then
    pass "Termux:X11 running"
else
    fail "Termux:X11 not running"
fi

echo
echo "========== Done =========="
