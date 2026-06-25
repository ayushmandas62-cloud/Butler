#!/data/data/com.termux/files/usr/bin/bash

# Butler Desktop
# Common helper functions

BUTLER_VERSION="0.1.0-dev"

info() {
    echo "[INFO] $1"
}

success() {
    echo "[ OK ] $1"
}

warn() {
    echo "[WARN] $1"
}

error() {
    echo "[FAIL] $1"
}

die() {
    error "$1"
    exit 1
}
