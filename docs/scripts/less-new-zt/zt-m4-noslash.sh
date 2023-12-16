#!/usr/bin/env sh

title=$1
shift

file="$ZETTELKASTEN""fleeting/$(date +%Y%m%d-%H%M%S).md"
cat $ZETTELKASTEN/notes-templates/newest-zt/include.scm $ZETTELKASTEN/notes-templates/newest-zt/template.md | guile --r7rs $ZETTELKASTEN/notes-templates/newest-zt/subscheme.scm -s title "$title" -s root "$file" -S tags "$file" "$@" "$file" > "$file"
nvim '+/#' "$file"
