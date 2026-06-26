#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

# Global installation
if [ $# -eq 0 ]; then
    mkdir -p "$PREFIX/bin"

    ln -sf "$PROJECT_ROOT/src/butler" "$PREFIX/bin/butler"
    chmod +x "$PROJECT_ROOT/src/butler"

    success "Butler installed successfully."
    echo
    echo "You can now run:"
    echo "    butler status"
    exit 0
fi

# Plugin installation
PLUGIN="$1"

CACHE_DIR="$HOME/.butler/repos"

REPO_DIR=""

for repo in "$CACHE_DIR"/*; do
    [ -d "$repo" ] || continue

    if [ -f "$repo/index.json" ] &&
       jq -e --arg plugin "$PLUGIN" \
       '.[] | select(.name == $plugin)' \
       "$repo/index.json" >/dev/null; then

        REPO_DIR="$repo"
        INDEX="$repo/index.json"
        break
    fi
done

if [ -z "$REPO_DIR" ]; then
    die "Plugin '$PLUGIN' not found in any repository."
fi

PLUGIN_DIR="$PROJECT_ROOT/plugins"

if [ ! -f "$INDEX" ]; then
    die "Repository index not found."
fi

if ! jq -e --arg plugin "$PLUGIN" \
'.[] | select(.name == $plugin)' \
"$INDEX" >/dev/null; then
    die "Plugin '$PLUGIN' is not available in the repository."
fi

DEPENDENCIES=$(jq -r --arg plugin "$PLUGIN" \
'.[] | select(.name == $plugin) | .depends[]?' \
"$INDEX")

for dep in $DEPENDENCIES; do
    if [ ! -f "$PLUGIN_DIR/$dep.sh" ]; then
        info "Installing dependency: $dep"
        "$SCRIPT_DIR/install.sh" "$dep"

        if [ $? -ne 0 ]; then
            die "Failed to install dependency: $dep"
        fi
    fi
done

if [ ! -f "$REPO_DIR/${PLUGIN}.sh" ]; then
    die "Plugin '$PLUGIN' not found."
fi

mkdir -p "$PLUGIN_DIR"

cp "$REPO_DIR/${PLUGIN}.sh" "$PLUGIN_DIR/"
chmod +x "$PLUGIN_DIR/${PLUGIN}.sh"

if [ -f "$REPO_DIR/${PLUGIN}.meta" ]; then
    cp "$REPO_DIR/${PLUGIN}.meta" "$PLUGIN_DIR/"
fi

success "Plugin '$PLUGIN' installed."
