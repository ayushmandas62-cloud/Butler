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

REPO_DIR="$PROJECT_ROOT/repository"
INDEX="$REPO_DIR/index"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

if [ ! -f "$INDEX" ]; then
    die "Repository index not found."
fi

if ! grep -Fxq "$PLUGIN" "$INDEX"; then
    die "Plugin '$PLUGIN' is not available in the repository."
fi

if [ -f "$REPO_DIR/${PLUGIN}.meta" ]; then
    cp "$REPO_DIR/${PLUGIN}.meta" "$PLUGIN_DIR/"
fi

if [ ! -f "$REPO_DIR/${PLUGIN}.sh" ]; then
    die "Plugin '$PLUGIN' not found."
fi

mkdir -p "$PLUGIN_DIR"

cp "$REPO_DIR/${PLUGIN}.sh" "$PLUGIN_DIR/"
chmod +x "$PLUGIN_DIR/${PLUGIN}.sh"

success "Plugin '$PLUGIN' installed."
