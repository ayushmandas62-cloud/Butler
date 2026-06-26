#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

REPO_DIR="$HOME/butler-desktop/repository"
INDEX="$REPO_DIR/index"

if [ ! -f "$INDEX" ]; then
    die "Repository index not found."
fi

echo "Available Plugins"
echo "-----------------"

cat "$INDEX"
