#!/data/data/com.termux/files/usr/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "$SCRIPT_DIR/../lib/common.sh"

CACHE_DIR="$HOME/.butler/repos"

INDEX=$(find "$CACHE_DIR" -name index.json | head -n1)

if [ -z "$INDEX" ]; then
    die "No repository index found."
fi

echo "Available Plugins"
echo "-----------------"

find "$CACHE_DIR" -name index.json | while read -r INDEX; do
    jq -r '
    .[] |
    [
      .name,
      "v" + .version,
      .author,
      .description
    ] | @tsv
    ' "$INDEX"
done | while IFS=$'\t' read -r name version author description; do
    printf "%-12s %-8s %-12s %s\n" \
        "$name" \
        "$version" \
        "$author" \
        "$description"
done
