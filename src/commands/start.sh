#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"
source "$SCRIPT_DIR/../lib/storage.sh"

launch_desktop() {
    info "Launching XFCE Desktop..."

    dbus-launch --exit-with-session startxfce4 \
        >"$HOME/butler-desktop/logs/xfce.log" 2>&1 &

    sleep 3

    success "XFCE launched in background."
}

start_x11() {
    info "Starting X11 bridge..."

    termux-x11 :0 >/dev/null 2>&1 &
    sleep 2

    success "X11 bridge started"
}

echo
info "Starting Butler..."
log "Butler startup initiated."

check_storage

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
start_x11

echo

info "Configuring display..."

export DISPLAY=:0

success "DISPLAY set to $DISPLAY"

echo

if command -v startxfce4 >/dev/null 2>&1; then
    launch_desktop
else
    die "startxfce4 is not installed"
fi

echo

success "Butler startup completed."
