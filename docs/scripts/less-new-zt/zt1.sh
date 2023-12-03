#!/usr/bin/env sh

string() {
	printf '"%s" ' "$@"
}

title=$1
shift

file="$ZETTELKASTEN/fleeting/$(date +%Y%m%d-%H%M%S).md"
$ZETTELKASTEN/notes-templates/template.sh --string=title="$title" --string=root="$file" --list=tags="$(printf '"%s" ' "$@")" < $ZETTELKASTEN/notes-templates/template.md > "$file"
nvim '+/#' "$file"
