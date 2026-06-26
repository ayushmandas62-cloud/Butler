#!/data/data/com.termux/files/usr/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

echo "Installed Plugins"
echo "-----------------"

if [ ! -d "$PLUGIN_DIR" ]; then
    echo "No plugins installed."
    exit 0
fi

found=0

for plugin in "$PLUGIN_DIR"/*.sh; do
    [ -f "$plugin" ] || continue
    basename "$plugin" .sh
    found=1
done

if [ "$found" -eq 0 ]; then
    echo "No plugins installed."
fi
