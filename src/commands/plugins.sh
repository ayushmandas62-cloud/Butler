#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

PLUGIN_DIR="$HOME/butler-desktop/plugins"

echo "Installed Plugins"
echo "-----------------"

if [ ! -d "$PLUGIN_DIR" ]; then
    echo "No plugins installed."
    exit 0
fi

found=false

for plugin in "$PLUGIN_DIR"/*.sh; do
    [ -e "$plugin" ] || continue
    basename "$plugin" .sh
    found=true
done

if [ "$found" = false ]; then
    echo "No plugins installed."
fi
