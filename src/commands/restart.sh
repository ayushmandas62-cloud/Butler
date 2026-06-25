#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

main() {
    info "Restarting Butler..."

    "$SCRIPT_DIR/stop.sh"

    sleep 2

    "$SCRIPT_DIR/start.sh"

    success "Butler restarted."
}

main
