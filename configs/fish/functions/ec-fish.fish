function ec-fish --description 'emacsclient'
    if test $TERM = "foot"
	set TERM foot-direct
	emacsclient -nw $argv
	set TERM foot
    else if test $TERM = "xterm-kitty"
	emacsclient -nw $argv
    end
end
