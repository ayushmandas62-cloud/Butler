#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(realpath "$SCRIPT_DIR/../..")"

source "$PROJECT_ROOT/src/config/repositories.conf"

echo "Repository Plugins"
echo "------------------"

INDEX=$(mktemp)

if ! curl -fsSL "$DEFAULT_REPO/index.json" -o "$INDEX"; then
    echo "Failed to fetch repository."
    rm -f "$INDEX"
    exit 1
fi

jq -r '.[] | "\(.name)\t\(.version)\t\(.description)"' "$INDEX" |
while IFS=$'\t' read -r name version description
do
    printf "%-18s %-8s %s\n" "$name" "$version" "$description"
done

rm -f "$INDEX"
