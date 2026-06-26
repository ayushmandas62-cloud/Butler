#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

exec "$PROJECT_ROOT/src/desktop/stop.sh"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"
source "$SCRIPT_DIR/../lib/stop.sh"

main() {
    info "Stopping Butler..."

    stop_desktop

    success "Butler stopped."
}

main
