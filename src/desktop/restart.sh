#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/desktop.conf"
source "$PROJECT_ROOT/src/lib/desktop.sh"

export DISPLAY="$DISPLAY"

restart_desktop
