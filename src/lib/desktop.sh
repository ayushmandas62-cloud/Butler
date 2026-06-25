#!/data/data/com.termux/files/usr/bin/bash

desktop_running() {
    pgrep -x xfce4-session >/dev/null
}

launch_desktop() {
    if desktop_running; then
        warn "XFCE Desktop is already running."
        return 0
    fi

    info "Launching XFCE Desktop..."

    dbus-launch --exit-with-session startxfce4 \
        >logs/xfce.log 2>&1 &

    sleep 3

    success "XFCE launched in background."
}
