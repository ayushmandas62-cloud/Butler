#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

DB="$HOME/.butler/installed.json"
CACHE_DIR="$HOME/.butler/repos"

latest_version_for() {
    local plugin="$1"
    local repo version

    while IFS= read -r repo; do
        version=$(jq -r --arg name "$plugin" \
            '.[] | select(.name == $name) | .version' \
            "$repo")

        if [ -n "$version" ] && [ "$version" != "null" ]; then
            printf '%s\n' "$version"
            return 0
        fi
    done < <(find "$CACHE_DIR" -name index.json)

    return 1
}

if [ $# -eq 0 ]; then
    echo "Checking for updates..."
    echo

    UPDATED=0

    while IFS=$'\t' read -r plugin installed; do
        latest=$(latest_version_for "$plugin" || true)

        if [ -n "$latest" ] && [ "$latest" != "$installed" ]; then
            "$SCRIPT_DIR/upgrade.sh" "$plugin"
            UPDATED=$((UPDATED + 1))
        fi
    done < <(jq -r '.[] | [.name, .version] | @tsv' "$DB")

    echo
    echo "$UPDATED package(s) upgraded."
    exit 0
fi

PLUGIN="$1"

info "Upgrading $PLUGIN..."
"$SCRIPT_DIR/install.sh" "$PLUGIN"
success "Plugin '$PLUGIN' upgraded."
