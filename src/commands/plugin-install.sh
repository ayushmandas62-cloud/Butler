#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

PLUGIN_DIR="$HOME/butler-desktop/plugins"

if [ $# -ne 1 ]; then
    die "Usage: butler plugin-install <plugin-file>"
fi

PLUGIN="$1"

if [ ! -f "$PLUGIN" ]; then
    die "Plugin file not found."
fi

mkdir -p "$PLUGIN_DIR"

cp "$PLUGIN" "$PLUGIN_DIR"

chmod +x "$PLUGIN_DIR/$(basename "$PLUGIN")"

success "Plugin installed."
