#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

main() {
    info "Restarting Butler..."

    "$SCRIPT_DIR/stop.sh"

    for i in {1..5}; do
        if ! pgrep -x xfwm4 >/dev/null &&
           ! pgrep -f termux-x11 >/dev/null &&
           ! pgrep -f dbus-daemon >/dev/null; then
            break
        fi

        sleep 1
    done

    "$SCRIPT_DIR/start.sh"

    success "Butler restarted."
}

main
