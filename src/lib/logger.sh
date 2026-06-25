#!/data/data/com.termux/files/usr/bin/bash

LOG_DIR="$HOME/butler-desktop/logs"
LOG_FILE="$LOG_DIR/butler.log"

mkdir -p "$LOG_DIR"

log() {
    printf "[%s] %s\n" "$(date '+%F %T')" "$1" >> "$LOG_FILE"
}
