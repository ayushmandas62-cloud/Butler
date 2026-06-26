#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

if [ $# -ne 1 ]; then
    die "Usage: butler plugin-info <plugin>"
fi

PLUGIN="$1"
DB="$HOME/.butler/installed.json"

if ! jq -e --arg name "$PLUGIN" \
'.[] | select(.name == $name)' \
"$DB" >/dev/null; then
    die "Plugin '$PLUGIN' is not installed."
fi

echo "Plugin Information"
echo "------------------"

jq -r --arg name "$PLUGIN" '
.[] | select(.name==$name) |
[
    "Name        : " + .name,
    "Version     : " + .version,
    "Author      : " + .author,
    "Description : " + .description,
    "Enabled     : " + (if .enabled then "Yes" else "No" end)
] | .[]
' "$DB"
