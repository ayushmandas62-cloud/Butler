#!/data/data/com.termux/files/usr/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

if [ -z "$1" ]; then
    echo "Usage: butler plugin remove <plugin>"
    exit 1
fi

PLUGIN="$1"

if [ ! -f "$PLUGIN_DIR/$PLUGIN.sh" ]; then
    echo "Plugin '$PLUGIN' is not installed."
    exit 1
fi

rm -f "$PLUGIN_DIR/$PLUGIN.sh"
rm -f "$PLUGIN_DIR/$PLUGIN.meta"

echo "[ OK ] Plugin '$PLUGIN' removed."
