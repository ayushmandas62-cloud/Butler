#!/data/data/com.termux/files/usr/bin/bash

stop_desktop() {
    info "Stopping XFCE Desktop..."

    pkill -x xfce4-session
    pkill -x xfwm4
    pkill -x xfsettingsd
    pkill -x xfce4-panel
    pkill -x Thunar
    pkill -f termux-x11
    pkill -f dbus-daemon

    success "XFCE stopped"
}
