#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

info "Starting Butler..."

echo
info "Checking storage..."

if [ -d "$HOME/storage/shared" ]; then
    success "Storage available"
else
    die "Storage permission missing. Run: termux-setup-storage"
fi

echo
info "Checking Termux:X11..."

if command -v termux-x11 >/dev/null 2>&1; then
    success "Termux:X11 installed"
else
    die "Termux:X11 is not installed"
fi

echo
success "Environment check completed."
echo
info "Starting D-Bus..."

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax)"
    success "D-Bus started"
else
    success "D-Bus already running"
fi

echo

info "Checking X11 server..."

if pgrep -f termux.x11 >/dev/null; then
    success "Termux:X11 is running"
else
    die "Termux:X11 is not running. Open the Termux:X11 app first."
fi

echo

info "Configuring display..."

export DISPLAY=:0

success "DISPLAY set to $DISPLAY"

echo

info "Launching test application..."

if command -v xfce4-terminal >/dev/null 2>&1; then
    xfce4-terminal &
    success "xfce4-terminal launched"
else
    die "xfce4-terminal is not installed"
fi

echo

success "Butler startup completed."
