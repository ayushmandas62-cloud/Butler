#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

DB="$HOME/.butler/installed.json"

if [ ! -f "$DB" ]; then
    echo "No packages installed."
    exit 0
fi

COUNT=$(jq 'length' "$DB")

if [ "$COUNT" -eq 0 ]; then
    echo "No packages installed."
    exit 0
fi

echo "Installed Packages"
echo "------------------"

jq -r '
.[] |
[
    .name,
    "v" + .version,
    (if .enabled then "Enabled" else "Disabled" end)
] | @tsv
' "$DB" |
while IFS=$'\t' read -r name version status; do
    printf "%-15s %-10s %s\n" \
        "$name" \
        "$version" \
        "$status"
done

echo
echo "Total: $COUNT package(s)"
