#!/usr/bin/env sh

title=$1
shift

file="$ZETTELKASTEN/fleeting/$(date +%Y%m%d-%H%M%S).md"
m4 --define=TITLE=$title --define=TAGS="$(printf -- '- %s\n' "$@")" --define=ROOT="$file" < $XDG_DOCUMENTS_DIR/notes/notes-templates/template.md.m4 > $file
nvim '+/#' "$file"
