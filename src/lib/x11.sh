#!/data/data/com.termux/files/usr/bin/bash

start_x11() {
    info "Starting X11 bridge..."

    termux-x11 :0 >/dev/null 2>&1 &
    sleep 2

    X11_PID=$(pgrep -f "termux.x11")

    if [ -n "$X11_PID" ]; then
        save_pid x11 "$X11_PID"
    fi

    success "X11 bridge started"
}

configure_display() {
    info "Configuring display..."

    export DISPLAY="${DISPLAY:-:0}"

    success "DISPLAY set to $DISPLAY"
}
