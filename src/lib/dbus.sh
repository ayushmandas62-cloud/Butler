#!/data/data/com.termux/files/usr/bin/bash

start_dbus() {
    info "Starting D-Bus..."

    if [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then
        success "D-Bus already running"
        return 0
    fi

    eval "$(dbus-launch --sh-syntax)"

    export DBUS_SESSION_BUS_ADDRESS
    export DBUS_SESSION_BUS_PID

    save_pid dbus "$DBUS_SESSION_BUS_PID"

    success "D-Bus started"
}
