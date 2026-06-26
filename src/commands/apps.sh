#!/data/data/com.termux/files/usr/bin/bash

case "$1" in
    list)
        echo "Installed Desktop Applications"
        echo "------------------------------"

        for app in thunar rofi firefox mousepad xterm; do
            if command -v "$app" >/dev/null 2>&1; then
                echo "✓ $app"
            fi
        done
        ;;

    launch)
        if [ -z "$2" ]; then
            echo "Usage: butler apps launch <application>"
            exit 1
        fi

        if command -v "$2" >/dev/null 2>&1; then
            "$2" &
        else
            echo "Application '$2' is not installed."
        fi
        ;;

    *)
        echo "Usage:"
        echo "  butler apps list"
        echo "  butler apps launch <application>"
        ;;
esac
