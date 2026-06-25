#!/data/data/com.termux/files/usr/bin/bash

log() {
    level="$1"
    shift

    printf "[%s] %s\n" "$level" "$*"
}

info() {
    log INFO "$@"
}

warn() {
    log WARN "$@"
}

error() {
    log FAIL "$@"
}

success() {
    log OK "$@"
}
