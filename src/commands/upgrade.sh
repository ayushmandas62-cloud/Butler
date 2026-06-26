#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

if [ $# -ne 1 ]; then
    die "Usage: butler upgrade <plugin>"
fi

PLUGIN="$1"

info "Upgrading $PLUGIN..."

"$SCRIPT_DIR/install.sh" "$PLUGIN"

success "Plugin '$PLUGIN' upgraded."
