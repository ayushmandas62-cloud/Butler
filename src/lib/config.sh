#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CONFIG_FILE="$SCRIPT_DIR/../../config/butler.conf"

load_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo "Configuration file not found: $CONFIG_FILE"
        return 1
    fi

    source "$CONFIG_FILE"

    required=(
        DISPLAY
        DESKTOP
        ENABLE_DBUS
        ENABLE_X11
        RUNTIME_DIR
        LOG_DIR
        MONITOR_INTERVAL
    )

    for var in "${required[@]}"; do
        if [ -z "${!var}" ]; then
            echo "Missing configuration: $var"
            return 1
        fi
    done
}
