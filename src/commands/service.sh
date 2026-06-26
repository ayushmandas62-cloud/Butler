#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/desktop.conf"

export DISPLAY="${DISPLAY:-:0}"

SERVICES="termux-x11 openbox polybar picom"

case "$1" in

    list)
        echo "Butler Services"
        echo "---------------"

        for service in $SERVICES; do
            if pgrep -f "$service" >/dev/null 2>&1; then
                printf "✓ %s\n" "$service"
            else
                printf "✗ %s\n" "$service"
            fi
        done
        ;;

    start)
        if [ -z "$2" ]; then
            echo "Usage: butler service start <service>"
            exit 1
        fi

        case "$2" in
            openbox)
                pgrep -x openbox >/dev/null || openbox &
                ;;
            polybar)
                pgrep -x polybar >/dev/null || polybar main &
                ;;
            picom)
                pgrep -x picom >/dev/null || picom &
                ;;
            *)
                echo "Unknown service: $2"
                exit 1
                ;;
        esac

        echo "[ OK ] $2 started."
        ;;

    stop)
        if [ -z "$2" ]; then
            echo "Usage: butler service stop <service>"
            exit 1
        fi

        pkill "$2" 2>/dev/null

        echo "[ OK ] $2 stopped."
        ;;

    *)
        echo "Usage:"
        echo "  butler service list"
        echo "  butler service start <service>"
        echo "  butler service stop <service>"
        ;;
esac
