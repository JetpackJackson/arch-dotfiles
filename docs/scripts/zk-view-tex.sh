#!/usr/bin/env bash

echo "1: View all"
echo "2: View school"
echo "3: View zettel"
read choice
case "$choice" in
    1) find $XDG_DOCUMENTS_DIR/notes/ -name '*.tex' | fzf --ansi +s -x -d '\034' --print-query --preview-window=right:50%:wrap --reverse --header='' --margin='1,2' --color='16,gutter:-1' --preview='head -$LINES {}' --bind 'enter:become(nvim {})'
    ;;
    2) find $XDG_DOCUMENTS_DIR/notes/school/ -name '*.tex' | fzf --ansi +s -x -d '\034' --print-query --preview-window=right:50%:wrap --reverse --header='' --margin='1,2' --color='16,gutter:-1' --preview='head -$LINES {}' --bind 'enter:become(nvim {})'
    ;;
    3) find $ZETTELKASTEN/ -name '*.tex' | fzf --ansi +s -x -d '\034' --print-query --preview-window=right:50%:wrap --reverse --header='' --margin='1,2' --color='16,gutter:-1' --preview='head -$LINES {}' --bind 'enter:become(nvim {})'
    ;;
    *) echo "Exiting."
    ;;
esac






#pale() { [[ -n `file "$1" | grep -o text` ]] && glow -p -w 109 -s dark "$1" }
#pale() { [[ $(file --mime "$1") =~ text ]] && glow -p -w 100 -s dark "$1" || { [[ -d "$1" ]] && exa -1 --icons -TL 2 {}; } }
#export -f pale()
