#!/bin/sh
# From: https://stackoverflow.com/a/70805078/7983959
style=${1:-zenburn}
tmp=
trap 'rm -f "$tmp"' EXIT
tmp=$(mktemp)
echo '$highlighting-css$' > "$tmp"
echo '`test`{.c}' | pandoc --highlight-style=$style --template=$tmp
