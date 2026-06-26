#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

case "$1" in
    list)
        "$SCRIPT_DIR/plugin-list.sh"
        ;;

    install)
        shift
        "$SCRIPT_DIR/plugin-install.sh" "$@"
        ;;

    remove)
        shift
        "$SCRIPT_DIR/plugin-remove.sh" "$@"
        ;;

    update)
        "$SCRIPT_DIR/plugin-update.sh"
        ;;

    *)
        echo "Usage:"
        echo "  butler plugin list"
        echo "  butler plugin install <plugin>"
        echo "  butler plugin remove <plugin>"
        echo "  butler plugin update"
        exit 1
        ;;
esac
