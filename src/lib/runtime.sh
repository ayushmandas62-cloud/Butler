#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/process.sh"

RUNTIME_DIR="$HOME/butler-desktop/runtime"

init_runtime() {
    mkdir -p "$RUNTIME_DIR"
}

runtime_file() {
    echo "$RUNTIME_DIR/$1"
}

create_lock() {
    echo $$ > "$(runtime_file session.lock)"
}

remove_lock() {
    rm -f "$(runtime_file session.lock)"
}

save_pid() {
    local service="$1"
    local pid="$2"

    mkdir -p "$RUNTIME_DIR/pids"
    echo "$pid" > "$RUNTIME_DIR/pids/${service}.pid"
}

get_pid() {
    local service="$1"
    local pidfile="$RUNTIME_DIR/pids/${service}.pid"

    if [ -f "$pidfile" ]; then
        cat "$pidfile"
    fi
}

remove_pid() {
    local service="$1"

    rm -f "$RUNTIME_DIR/pids/${service}.pid"
}

service_running() {
    local service="$1"

    case "$service" in
        xfce)
            process_running xfce4-session
            ;;
        dbus)
            process_running dbus-daemon
            ;;
        x11)
            process_running termux-x11
            ;;
        *)
            return 1
            ;;
    esac
}

