#!/data/data/com.termux/files/usr/bin/bash

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

echo "Available Plugins"
echo "-----------------"

QUERY="$1"

FOUND=0

for meta in "$PLUGIN_DIR"/*.meta; do
    [ -f "$meta" ] || continue

    source "$meta"

    if [ -z "$QUERY" ] || echo "$NAME $DESCRIPTION" | grep -qi "$QUERY"; then
        printf "%-20s %s\n" "$NAME" "$DESCRIPTION"
        FOUND=1
    fi
done

if [ "$FOUND" -eq 0 ]; then
    echo "No matching plugins found."
fi
