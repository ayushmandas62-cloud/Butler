#!/data/data/com.termux/files/usr/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

if [ -z "$1" ]; then
    echo "Usage: butler plugin create <name>"
    exit 1
fi

NAME="$1"

mkdir -p "$PLUGIN_DIR"

if [ -f "$PLUGIN_DIR/$NAME.sh" ]; then
    echo "Plugin '$NAME' already exists."
    exit 1
fi

cat > "$PLUGIN_DIR/$NAME.sh" <<EOF
#!/data/data/com.termux/files/usr/bin/bash

echo "$NAME plugin works!"
EOF

chmod +x "$PLUGIN_DIR/$NAME.sh"

cat > "$PLUGIN_DIR/$NAME.meta" <<EOF
NAME="$NAME"
VERSION="1.0.0"
AUTHOR="Unknown"
DESCRIPTION="$NAME plugin"
ENABLED="true"
EOF

INSTALLED_DB="$HOME/.butler/installed.json"

mkdir -p "$(dirname "$INSTALLED_DB")"

[ -f "$INSTALLED_DB" ] || echo "[]" > "$INSTALLED_DB"

tmp=$(mktemp)

jq \
--arg name "$NAME" \
--arg version "1.0.0" \
--arg author "Unknown" \
--arg description "$NAME plugin" \
'
map(select(.name != $name))
+
[{
    name:$name,
    version:$version,
    author:$author,
    description:$description,
    enabled:true
}]
' "$INSTALLED_DB" > "$tmp"

mv "$tmp" "$INSTALLED_DB"

echo
echo "[ OK ] Plugin '$NAME' created."
echo
echo "Files:"
echo "  $PLUGIN_DIR/$NAME.sh"
echo "  $PLUGIN_DIR/$NAME.meta"
