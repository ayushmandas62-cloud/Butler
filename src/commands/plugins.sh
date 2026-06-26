#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

PLUGIN_DIR="$HOME/butler-desktop/plugins"

if [ ! -d "$PLUGIN_DIR" ]; then
    echo "No plugins installed."
    exit 0
fi

found=false

for plugin in "$PLUGIN_DIR"/*.sh "$PLUGIN_DIR"/*.disabled; do
    [ -e "$plugin" ] || continue

    filename=$(basename "$plugin")

case "$filename" in
    *.sh)
        name="${filename%.sh}"
        status="Enabled"
        ;;
    *.disabled)
        name="${filename%.disabled}"
        status="Disabled"
        ;;
esac

    meta="$PLUGIN_DIR/${name}.meta"

    if [ -f "$meta" ]; then
        source "$meta"
        printf "%-12s v%-8s %-9s %s\n" \
        "$name" \
        "$VERSION" \
        "$status" \
        "$DESCRIPTION"

    else
        printf "%-12s\n" "$name"
    fi

    found=true
done

if [ "$found" = false ]; then
    echo "No plugins installed."
fi

