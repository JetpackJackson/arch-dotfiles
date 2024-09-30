#!/usr/bin/env fish

#if [[ $TERM == "foot" ]]; then
#    TERM=foot-direct emacsclient -nw "$@"
#elif [[ $TERM == "xterm-kitty" ]]; then
#    emacsclient -nw "$@"
#fi
#if test $TERM = "foot"
#    TERM=foot-direct emacsclient -nw $argv
#else if test $TERM = "xterm-kitty"
#    emacsclient -nw $argv
#end
TERM=xterm emacsclient -t $argv
