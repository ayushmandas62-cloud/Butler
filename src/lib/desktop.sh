#!/data/data/com.termux/files/usr/bin/bash

desktop_running() {
    pgrep -x openbox >/dev/null &&
    pgrep -x polybar >/dev/null
}

x11_running() {
    pgrep -f "termux.x11" >/dev/null
}

start_x11() {
    if ! x11_running; then
        termux-x11 :0 >/dev/null 2>&1 &
        sleep 2
    fi
}

start_openbox() {
    pgrep -x openbox >/dev/null || openbox &
}

start_polybar() {
    pgrep -x polybar >/dev/null || polybar main &
}

stop_openbox() {
    pkill openbox
}

stop_polybar() {
    pkill polybar
}

start_desktop() {
    export DISPLAY=:0

    start_x11
    start_openbox
    start_polybar
}

stop_desktop() {
    stop_polybar
    stop_openbox
}

restart_desktop() {
    stop_desktop
    sleep 1
    start_desktop
}
