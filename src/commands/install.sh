#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"
source "$SCRIPT_DIR/../lib/logger.sh"

PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

mkdir -p "$PREFIX/bin"

ln -sf "$PROJECT_ROOT/src/butler" "$PREFIX/bin/butler"

chmod +x "$PROJECT_ROOT/src/butler"

echo
success "Butler installed successfully."
echo "You can now run:"
echo
echo "    butler status"
