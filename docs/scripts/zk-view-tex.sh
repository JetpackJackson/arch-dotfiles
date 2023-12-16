#!/usr/bin/env bash
find $ZETTELKASTEN -name '*.tex' | fzf --ansi +s -x -d '\034' --print-query --preview-window=right:50%:wrap --reverse --header='' --margin='1,2' --color='16,gutter:-1' --preview='head -$LINES {}' --bind 'enter:become(nvim {})'

#pale() { [[ -n `file "$1" | grep -o text` ]] && glow -p -w 109 -s dark "$1" }
#pale() { [[ $(file --mime "$1") =~ text ]] && glow -p -w 100 -s dark "$1" || { [[ -d "$1" ]] && exa -1 --icons -TL 2 {}; } }
#export -f pale()
