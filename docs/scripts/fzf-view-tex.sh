#!/usr/bin/env bash

echo "1: View all"
echo "2: View school"
echo "3: View zettel"
read choice
case "$choice" in
    1) find $XDG_DOCUMENTS_DIR/notes/ -not -path '*/.stversions/*' -name '*.tex' | fzf --ansi +s -x -d '\034' --print-query --preview-window=right:50%:wrap --reverse --header='' --margin='1,2' --color='16,gutter:-1' --preview='head -$LINES | pistol {}' --bind 'enter:become(nvim {})'
    ;;
    2) find $XDG_DOCUMENTS_DIR/notes/school/ -not -path '*/.stversions/*' -name '*.tex' | fzf --ansi +s -x -d '\034' --print-query --preview-window=right:50%:wrap --reverse --header='' --margin='1,2' --color='16,gutter:-1' --preview='head -$LINES | pistol {}' --bind 'enter:become(nvim {})'
    ;;
    3) find $ZETTELKASTEN/ -not -path '*/.stversions/*' -name '*.tex' | fzf --ansi +s -x -d '\034' --print-query --preview-window=right:50%:wrap --reverse --header='' --margin='1,2' --color='16,gutter:-1' --preview='head -$LINES | pistol {}' --bind 'enter:become(nvim {})'
    ;;
    *) echo "Exiting."
    ;;
esac

