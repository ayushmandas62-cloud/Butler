#!/data/data/com.termux/files/usr/bin/bash

process_running() {
    pgrep -f "$1" >/dev/null
}

process_pid() {
    pgrep -fo "$1"
}

kill_process() {
    pkill -f "$1"
}

