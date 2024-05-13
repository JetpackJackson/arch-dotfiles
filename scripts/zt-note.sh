#!/usr/bin/env sh

class=$1

title=$2
shift

file="$XDG_DOCUMENTS_DIR/notes/school/$class/$(date +%Y%m%d-%H%M%S).md"
m4 --define=TITLE=$title --define=TAGS="$(printf -- '- %s\n' "$@")" --define=ROOT="$file" --define=CLASS="$class" < $XDG_DOCUMENTS_DIR/notes/notes-templates/note.md.m4 > $file
nvim '+/#' "$file"
