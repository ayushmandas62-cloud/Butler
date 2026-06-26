#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

SOURCE="$HOME/butler-packages"
DEST="$HOME/butler-desktop/repository"

if [ ! -d "$SOURCE" ]; then
    die "Repository source not found: $SOURCE"
fi

mkdir -p "$DEST"

cp -r "$SOURCE/"* "$DEST/"

success "Repository updated."
