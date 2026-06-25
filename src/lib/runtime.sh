#!/data/data/com.termux/files/usr/bin/bash

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
