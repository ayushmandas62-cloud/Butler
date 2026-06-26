#!/data/data/com.termux/files/usr/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PLUGIN_DIR="$PROJECT_ROOT/plugins"
REPO_DIR="$HOME/Butler-Plugins"

if [ -z "$1" ]; then
    echo "Usage: butler plugin publish <plugin>"
    exit 1
fi

PLUGIN="$1"

if [ ! -f "$PLUGIN_DIR/$PLUGIN.sh" ]; then
    echo "Plugin '$PLUGIN' not found."
    exit 1
fi

if [ ! -f "$PLUGIN_DIR/$PLUGIN.meta" ]; then
    echo "Plugin '$PLUGIN.meta' not found."
    exit 1
fi

mkdir -p "$REPO_DIR/$PLUGIN"

cp "$PLUGIN_DIR/$PLUGIN.sh" "$REPO_DIR/$PLUGIN/"
cp "$PLUGIN_DIR/$PLUGIN.meta" "$REPO_DIR/$PLUGIN/"

META="$PLUGIN_DIR/$PLUGIN.meta"
source "$META"

INDEX="$REPO_DIR/index.json"

[ -f "$INDEX" ] || echo "[]" > "$INDEX"

tmp=$(mktemp)

jq \
--arg name "$NAME" \
--arg version "$VERSION" \
--arg author "$AUTHOR" \
--arg description "$DESCRIPTION" \
'
map(select(.name != $name))
+
[{
    name:$name,
    version:$version,
    author:$author,
    description:$description
}]
' "$INDEX" > "$tmp"

mv "$tmp" "$INDEX"

echo "[ OK ] Plugin '$PLUGIN' published."
echo "[ OK ] Repository index updated."
echo
echo "Location:"
echo "  $REPO_DIR/$PLUGIN"

cd "$REPO_DIR" || exit 1

git add .

if git diff --cached --quiet; then
    echo "[ OK ] Nothing to commit."
    exit 0
fi

git commit -m "Publish plugin: $PLUGIN"

if git push; then
    echo
    echo "[ OK ] Plugin published to GitHub."
else
    echo
    echo "[FAIL] Git push failed."
    exit 1
fi
