#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

exec "$PROJECT_ROOT/src/desktop/start.sh"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"
source "$SCRIPT_DIR/../lib/storage.sh"
source "$SCRIPT_DIR/../lib/dbus.sh"
source "$SCRIPT_DIR/../lib/x11.sh"
source "$SCRIPT_DIR/../lib/desktop.sh"
source "$SCRIPT_DIR/../lib/runtime.sh"
source "$SCRIPT_DIR/../lib/config.sh"

load_config

termux-wake-lock 2>/dev/null || true

main() {

echo
info "Starting Butler..."
log "Butler startup initiated."

init_runtime

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

if [ "$ENABLE_DBUS" = "true" ]; then
    start_dbus
fi

echo
if [ "$ENABLE_X11" = "true" ]; then
    start_x11
fi

echo
export DISPLAY="$DISPLAY"
configure_display

echo
launch_desktop

echo
success "Butler startup completed."

}

main
