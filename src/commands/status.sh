#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"
source "$SCRIPT_DIR/../lib/runtime.sh"
source "$SCRIPT_DIR/../lib/process.sh"

main() {
    info "Butler Status"

    echo

    if service_running xfce; then
        success "Desktop : Running"
        echo "Session PID : $(get_pid xfce)"
        echo "Current PID : $(process_pid xfce4-session)"
    else
       berror "Desktop : Stopped"
    fi

    if pgrep -f dbus-daemon >/dev/null; then
        success "D-Bus : Running"
        echo "D-Bus PID : $(process_pid dbus-daemon)"
    else
        error "D-Bus : Stopped"
    fi

    if pgrep -f termux-x11 >/dev/null; then
        success "Termux:X11 : Running"
        echo "Termux:X11 PID : $(process_pid termux-x11)"
    else
        error "Termux:X11 : Stopped"
    fi

}

main

