#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

BACKUP_DIR="$HOME/butler-desktop/backups"
TIMESTAMP=$(date +"%Y%m%d-%H%M%S")

mkdir -p "$BACKUP_DIR"

DEST="$BACKUP_DIR/butler-$TIMESTAMP"

mkdir -p "$DEST"

cp -r configs "$DEST/"
cp -r logs "$DEST/" 2>/dev/null
cp -r runtime "$DEST/" 2>/dev/null

ARCHIVE="${DEST}.tar.gz"

tar -czf "$ARCHIVE" -C "$BACKUP_DIR" "$(basename "$DEST")"

rm -rf "$DEST"

success "Backup archive created:"
echo "$ARCHIVE"
