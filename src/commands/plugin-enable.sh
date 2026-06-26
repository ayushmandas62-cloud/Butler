#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

if [ $# -ne 1 ]; then
    die "Usage: butler plugin-enable <plugin>"
fi

PLUGIN="$1"

if [ ! -f "$PLUGIN_DIR/${PLUGIN}.disabled" ]; then
    die "Plugin '$PLUGIN' is not disabled."
fi

mv "$PLUGIN_DIR/${PLUGIN}.disabled" "$PLUGIN_DIR/${PLUGIN}.sh"

success "Plugin '$PLUGIN' enabled."
