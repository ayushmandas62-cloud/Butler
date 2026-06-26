#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/common.sh"
source "$SCRIPT_DIR/logger.sh"
source "$SCRIPT_DIR/process.sh"
source "$SCRIPT_DIR/runtime.sh"
source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/storage.sh"
source "$SCRIPT_DIR/dbus.sh"
source "$SCRIPT_DIR/x11.sh"
source "$SCRIPT_DIR/desktop.sh"
source "$SCRIPT_DIR/stop.sh"

load_config
init_runtime
