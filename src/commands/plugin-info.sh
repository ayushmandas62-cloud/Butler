#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"
PLUGIN_DIR="$PROJECT_ROOT/plugins"

if [ $# -ne 1 ]; then
    die "Usage: butler plugin-info <plugin>"
fi

PLUGIN="$1"
META="$PLUGIN_DIR/${PLUGIN}.meta"

if [ ! -f "$META" ]; then
    die "Plugin '$PLUGIN' not found."
fi

source "$META"

echo "Plugin Information"
echo "------------------"
echo "Name        : $NAME"
echo "Version     : $VERSION"
echo "Author      : $AUTHOR"
echo "Description : $DESCRIPTION"
echo "Executable  : ${PLUGIN}.sh"
