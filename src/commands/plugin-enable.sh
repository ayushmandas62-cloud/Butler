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
INSTALLED_DB="$HOME/.butler/installed.json"

if ! jq -e --arg name "$PLUGIN" \
'.[] | select(.name == $name)' \
"$INSTALLED_DB" >/dev/null; then
    die "Plugin '$PLUGIN' not installed."
fi

tmp=$(mktemp)

jq --arg name "$PLUGIN" '
map(
    if .name == $name
    then .enabled = true
    else .
    end
)
' "$INSTALLED_DB" > "$tmp"

mv "$tmp" "$INSTALLED_DB"

success "Plugin '$PLUGIN' enabled."
