#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

BACKUP_DIR="$HOME/butler-desktop/backups"

ARCHIVE="$1"

if [ -z "$ARCHIVE" ]; then
    die "Usage: butler restore <backup.tar.gz>"
fi

if [ ! -f "$BACKUP_DIR/$ARCHIVE" ]; then
    die "Backup not found."
fi

tar -xzf "$BACKUP_DIR/$ARCHIVE" -C "$HOME/butler-desktop"

success "Backup restored."
