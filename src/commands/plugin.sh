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
    search)
        shift
        "$SCRIPT_DIR/plugin-search.sh" "$@"
        ;;
    repo)
        "$SCRIPT_DIR/plugin-repo.sh"
        ;;
    info)
        shift
        "$SCRIPT_DIR/plugin-info.sh" "$@"
        ;;

    enable)
        shift
        "$SCRIPT_DIR/plugin-enable.sh" "$@"
        ;;

    disable)
        shift
        "$SCRIPT_DIR/plugin-disable.sh" "$@"
        ;;
    create)
        shift
        "$SCRIPT_DIR/plugin-create.sh" "$@"
        ;;
    publish)
        shift
        "$SCRIPT_DIR/plugin-publish.sh" "$@"
        ;;
    *)

        echo "Usage:"
        echo "  butler plugin list"
        echo "  butler plugin search"
        echo "  butler plugin install <plugin>"
        echo "  butler plugin remove <plugin>"
        echo "  butler plugin update"
        echo "  butler plugin repo"
        echo "  butler plugin info <plugin>"
	echo "  butler plugin enable <plugin>"
	echo "  butler plugin disable <plugin>"
	echo "  butler plugin create <plugin>"
	echo "  butler plugin publish <plugin>"
        ;;
esac
