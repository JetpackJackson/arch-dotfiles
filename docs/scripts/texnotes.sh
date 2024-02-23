#!/usr/bin/env sh

find $ZETTELKASTEN -name '*.tex' | sort -n | fzf --preview 'pistol {}' --bind 'enter:become(nvim {})'
