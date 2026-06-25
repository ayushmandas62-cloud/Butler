#!/data/data/com.termux/files/usr/bin/bash

stop_desktop() {
    info "Stopping XFCE Desktop..."

    pkill -x xfce4-session
    pkill -x xfwm4
    pkill -x xfsettingsd

    success "XFCE stopped"
}
