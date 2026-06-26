#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

DB="$HOME/.butler/installed.json"

if [ ! -f "$DB" ]; then
    echo "No plugins installed."
    exit 0
fi

count=$(jq 'length' "$DB")

if [ "$count" -eq 0 ]; then
    echo "No plugins installed."
    exit 0
fi

jq -r '
.[] |
[
    .name,
    .version,
    (if .enabled then "Enabled" else "Disabled" end),
    .description
] | @tsv
' "$DB" | while IFS=$'\t' read -r name version status description; do
    printf "%-12s v%-8s %-9s %s\n" \
        "$name" \
        "$version" \
        "$status" \
        "$description"
done
