#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

REPO_DIR="$HOME/butler-desktop/configs/repos"

mkdir -p "$REPO_DIR"

case "$1" in
    add)
        [ $# -eq 3 ] || die "Usage: butler repo add <name> <url>"
        echo "$3" > "$REPO_DIR/$2"
        success "Repository '$2' added."
        ;;

    list)
        echo "Configured Repositories"
        echo "-----------------------"

        for repo in "$REPO_DIR"/*; do
            [ -e "$repo" ] || continue
            printf "%-15s %s\n" "$(basename "$repo")" "$(cat "$repo")"
        done
        ;;

    remove)
        [ $# -eq 2 ] || die "Usage: butler repo remove <name>"
        rm -f "$REPO_DIR/$2"
        success "Repository '$2' removed."
        ;;

    *)
        echo "Usage:"
        echo "  butler repo add <name> <url>"
        echo "  butler repo list"
        echo "  butler repo remove <name>"
        ;;
esac
