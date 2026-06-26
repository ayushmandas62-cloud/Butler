#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

cd "$PROJECT_ROOT" || exit 1

echo "Updating Butler..."
echo

git pull --ff-only

if [ $? -eq 0 ]; then
    echo
    echo "[ OK ] Butler updated successfully."
else
    echo
    echo "[FAIL] Butler update failed."
    exit 1
fi
