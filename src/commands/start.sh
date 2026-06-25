#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/../lib/common.sh"

info "Starting Butler..."

echo
info "Checking storage..."

if [ -d "$HOME/storage/shared" ]; then
    success "Storage available"
else
    die "Storage permission missing. Run: termux-setup-storage"
fi

echo
info "Checking Termux:X11..."

if command -v termux-x11 >/dev/null 2>&1; then
    success "Termux:X11 installed"
else
    die "Termux:X11 is not installed"
fi

echo
success "Environment check completed."
echo
info "Desktop startup is not implemented yet."
