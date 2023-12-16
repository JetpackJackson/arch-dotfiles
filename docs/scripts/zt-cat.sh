#!/usr/bin/env sh

title=$1
shift

file="$ZETTELKASTEN""/fleeting/$(date +%Y%m%d-%H%M%S).md"
cat $XDG_DOCUMENTS_DIR/notes/notes-templates/include.scm $XDG_DOCUMENTS_DIR/notes/notes-templates/template.md | guile --r7rs $XDG_DOCUMENTS_DIR/notes/notes-templates/subscheme.scm -s title "$title" -s root "$file" -S tags "$file" "$@" "$file" > "$file"
nvim '+/#' "$file"
