#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"
source "$SCRIPT_DIR/../lib/runtime.sh"
source "$SCRIPT_DIR/../lib/dbus.sh"
source "$SCRIPT_DIR/../lib/x11.sh"
source "$SCRIPT_DIR/../lib/desktop.sh"

monitor_loop() {
    info "Monitoring Butler services..."

    while true; do

        if ! service_running dbus; then
            warn "D-Bus stopped. Restarting..."
            log "D-Bus stopped. Restarting service."
            start_dbus
        fi

        if ! service_running x11; then
            warn "Termux:X11 stopped. Restarting..."
            log "Termux:X11 stopped. Restarting service."
            start_x11
        fi

        if ! service_running xfce; then
            warn "Desktop stopped. Restarting..."
            log "Desktop crashed. Restarting XFCE."
            launch_desktop
        fi

        sleep 5
    done
}

main() {
    monitor_loop
}

main
