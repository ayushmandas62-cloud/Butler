#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"
source "$SCRIPT_DIR/../lib/storage.sh"
source "$SCRIPT_DIR/../lib/dbus.sh"
source "$SCRIPT_DIR/../lib/x11.sh"
source "$SCRIPT_DIR/../lib/desktop.sh"

main() {

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

start_dbus

echo
start_x11

echo
configure_display

echo
launch_desktop

echo
success "Butler startup completed."
}

main
