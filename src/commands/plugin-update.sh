#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

PLUGIN_DIR="$HOME/butler-desktop/plugins"
CACHE_DIR="$HOME/.butler/repos"

echo "Available Plugin Updates"
echo "------------------------"

for meta in "$PLUGIN_DIR"/*.meta; do
    [ -f "$meta" ] || continue

    source "$meta"

    INSTALLED="$VERSION"
    NAME=$(basename "$meta" .meta)

    find "$CACHE_DIR" -name index.json | while read -r INDEX; do
        REMOTE=$(jq -r --arg name "$NAME" \
        '.[] | select(.name==$name) | .version' "$INDEX")

        if [ -n "$REMOTE" ] && [ "$REMOTE" != "null" ] && [ "$REMOTE" != "$INSTALLED" ]; then
            printf "%-12s %s -> %s\n" "$NAME" "$INSTALLED" "$REMOTE"
        fi
    done
done
