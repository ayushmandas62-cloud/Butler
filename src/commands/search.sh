#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

REPO_DIR="$HOME/butler-desktop/repository"
INDEX="$REPO_DIR/index.json"

if [ ! -f "$INDEX" ]; then
    die "Repository index not found."
fi

echo "Available Plugins"
echo "-----------------"

jq -r '
.[] |
[
  .name,
  "v" + .version,
  .author,
  .description
] | @tsv
' "$INDEX" | while IFS=$'\t' read -r name version author description; do
    printf "%-12s %-8s %-12s %s\n" \
        "$name" \
        "$version" \
        "$author" \
        "$description"
done
