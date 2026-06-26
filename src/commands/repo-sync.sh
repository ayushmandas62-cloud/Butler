#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

CONFIG_DIR="$HOME/butler-desktop/configs/repos"
CACHE_DIR="$HOME/.butler/repos"

mkdir -p "$CACHE_DIR"

for repo in "$CONFIG_DIR"/*; do
    [ -f "$repo" ] || continue

    name=$(basename "$repo")
    url=$(cat "$repo")

    if [ -d "$CACHE_DIR/$name/.git" ]; then
        info "Updating $name..."
        git -C "$CACHE_DIR/$name" pull --ff-only
    else
        info "Cloning $name..."
        git clone "$url" "$CACHE_DIR/$name"
    fi
done

success "Repositories synchronized."
