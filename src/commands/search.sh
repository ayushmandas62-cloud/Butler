#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

REPO_DIR="$HOME/butler-desktop/repository"

echo "Available Plugins"
echo "-----------------"

for plugin in "$REPO_DIR"/*.sh; do
    [ -e "$plugin" ] || continue
    basename "$plugin" .sh
done
