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
INSTALLED_DB="$HOME/.butler/installed.json"

if [ ! -f "$PLUGIN_DIR/${PLUGIN}.sh" ]; then
    die "Plugin '$PLUGIN' is not installed."
fi

rm "$PLUGIN_DIR/${PLUGIN}.sh"
rm -f "$PLUGIN_DIR/${PLUGIN}.meta"
rm -f "$PLUGIN_DIR/${PLUGIN}.disabled"

tmp=$(mktemp)

jq --arg name "$PLUGIN" '
map(select(.name != $name))
' "$INSTALLED_DB" > "$tmp"

mv "$tmp" "$INSTALLED_DB"

success "Plugin '$PLUGIN' removed."
