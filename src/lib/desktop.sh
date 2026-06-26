#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/desktop.conf"

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
    export DISPLAY="${DISPLAY:-:0}"

    start_x11

    case "$WM" in
        openbox)
            "$PROJECT_ROOT/src/desktops/openbox.sh"
            ;;
        xfce)
	pgrep -x xfce4-session >/dev/null || DISPLAY="$DISPLAY" startxfce4 &
            ;;
        *)
            echo "Unsupported window manager: $WM"
            return 1
            ;;
    esac

    case "$BAR" in
        polybar)
            start_polybar
            ;;
        xfce4-panel)
            pgrep -x xfce4-panel >/dev/null || xfce4-panel &
            ;;
    esac
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
