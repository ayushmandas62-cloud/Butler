#!/data/data/com.termux/files/usr/bin/bash

check_storage() {
    info "Checking storage..."

    if [ -d "$HOME/storage" ]; then
        success "Storage available"
    else
        die "Storage permission not granted."
    fi
}
