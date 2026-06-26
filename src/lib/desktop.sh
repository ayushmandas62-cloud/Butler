#!/data/data/com.termux/files/usr/bin/bash

desktop_running() {
    pgrep -x xfce4-session >/dev/null
}

launch_desktop() {
    if desktop_running; then
        info "XFCE Desktop is already running."
        return 0
    fi

    info "Launching XFCE Desktop..."

    startxfce4 > logs/xfce.log 2>&1 &

    for i in {1..10}; do
        XFCE_PID=$(pgrep -x xfce4-session)
        [ -n "$XFCE_PID" ] && break
        sleep 1
    done

    if [ -n "$XFCE_PID" ]; then
        save_pid xfce "$XFCE_PID"
    fi

    echo "xfce4-session PID: $(pgrep -x xfce4-session)" >> logs/xfce.log
    echo "dbus-daemon PID: $(pgrep -x dbus-daemon)" >> logs/xfce.log

    if [ -n "$XFCE_PID" ]; then
        success "XFCE launched successfully."
    else
        error "XFCE failed to start."
        return 1
    fi
}

