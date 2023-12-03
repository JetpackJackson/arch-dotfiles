#!/usr/bin/env sh

title=$1
shift

file="$ZETTELKASTEN/fleeting/$(date +%Y%m%d-%H%M%S).md"
cat include.scm template.md | guile --r7rs subscheme.scm -s title "$title" -s root "$file" -S tags "$file" "$@" "$file" > "$file"
nvim '+/#' "$file"
