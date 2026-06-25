#!/data/data/com.termux/files/usr/bin/bash

start_dbus() {
    info "Starting D-Bus..."

    export $(dbus-launch)

    success "D-Bus started"
}
