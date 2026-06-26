#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

PROFILE_DIR="$PROJECT_ROOT/src/profiles"
CONFIG_FILE="$PROJECT_ROOT/src/config/desktop.conf"

case "$1" in
    current)
        echo "Current Desktop Profile"
        echo "-----------------------"

        source "$CONFIG_FILE"

        echo "$WM"

        exit 0
        ;;
    list)
        echo "Installed Desktop Profiles"
        echo "--------------------------"

        for profile in "$PROFILE_DIR"/*.conf; do
            [ -f "$profile" ] || continue
            basename "$profile" .conf
        done
        ;;

    use)
        if [ -z "$2" ]; then
            echo "Usage: butler desktop use <profile>"
            exit 1
        fi

        if [ ! -f "$PROFILE_DIR/$2.conf" ]; then
            echo "Profile '$2' not found."
            exit 1
        fi

        cp "$PROFILE_DIR/$2.conf" "$CONFIG_FILE"

        echo
	echo "[ OK ] Desktop profile '$2' activated."
	echo
	echo "Restart Butler Desktop to apply changes:"
	echo
	echo "    butler restart"
        ;;

    *)
        echo "Usage:"
        echo "  butler desktop list"
        echo "  butler desktop use <profile>"
        ;;
esac
