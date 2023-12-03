#!/usr/bin/env sh

string() {
    printf '"%s" ' "$@"
}

title=$1
shift

file="$ZETTELKASTEN/fleeting/$(date +%Y%m%d-%H%M%S).md"
m4 --define=TITLE=$title --define=TAGS="$(printf -- '- %s\n' "$@")" --define=ROOT="$file" < $ZETTELKASTEN/notes-templates/template.md.m4 > $file
nvim '+/#' "$file"
