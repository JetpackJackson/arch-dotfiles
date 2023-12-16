#!/usr/bin/env sh

title=$1
langs=$2
shift

file="$ZETTELKASTEN""/fleeting/$(date +%Y%m%d-%H%M%S).tex"
m4 --define=TITLE=$title --define=LANG=$langs --define=ROOT="$file" < $XDG_DOCUMENTS_DIR/notes/notes-templates/note.tex.m4 > $file
nvim '+/#' "$file"
