#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/repositories.conf"

PLUGIN="$1"

if [ -z "$PLUGIN" ]; then
    echo "Usage: butler plugin install <plugin>"
    exit 1
fi

PLUGIN_DIR="$PROJECT_ROOT/plugins"
mkdir -p "$PLUGIN_DIR"

TMP=$(mktemp)

echo "Fetching repository..."

if ! curl -fsSL "$DEFAULT_REPO/index.json" -o "$TMP"; then
    echo "Failed to fetch repository index."
    rm -f "$TMP"
    exit 1
fi

FOUND=$(jq -r --arg name "$PLUGIN" \
'.[] | select(.name==$name) | .name' "$TMP")

if [ -z "$FOUND" ]; then
    echo "Plugin '$PLUGIN' not found."
    rm -f "$TMP"
    exit 1
fi

echo "Downloading $PLUGIN..."

curl -fsSL \
"$DEFAULT_REPO/$PLUGIN/$PLUGIN.sh" \
-o "$PLUGIN_DIR/$PLUGIN.sh"

curl -fsSL \
"$DEFAULT_REPO/$PLUGIN/$PLUGIN.meta" \
-o "$PLUGIN_DIR/$PLUGIN.meta"

chmod +x "$PLUGIN_DIR/$PLUGIN.sh"

rm -f "$TMP"

echo
echo "[ OK ] Plugin '$PLUGIN' installed."
