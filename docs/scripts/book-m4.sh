#!/usr/bin/env sh

title=$1
subtitle=$2
shift

file="$ZETTELKASTEN""/fleeting/$(date +%Y%m%d-%H%M%S).tex"
m4 --define=TITLE=$title --define=SUBTITLE=$subtitle --define=ROOT="$file" < $ZETTELKASTEN/notes-templates/book.tex.m4 > $file
nvim '+/#' "$file"
