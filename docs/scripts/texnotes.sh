#!/usr/bin/env sh

find $ZETTELKASTEN -name '*.tex' | sort -n | fzf --bind 'enter:become(nvim {})'
