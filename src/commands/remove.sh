#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

if [ $# -ne 1 ]; then
    die "Usage: butler remove <plugin>"
fi

PLUGIN="$1"

if [ ! -f "$PLUGIN_DIR/${PLUGIN}.sh" ]; then
    die "Plugin '$PLUGIN' is not installed."
fi

rm "$PLUGIN_DIR/${PLUGIN}.sh"

success "Plugin '$PLUGIN' removed."
