# prompt
function fish_prompt
    # This is a simple prompt. It looks like
    # alfa@nobby /path/to/dir $
    # with the path shortened and colored
    # and a "#" instead of a "$" when run as root.
    if fish_is_root_user
        set symbol ' # '
        set -q fish_color_cwd_root
        and set color $fish_color_cwd_root
    end
    if test -n "$GUIX_ENVIRONMENT"
        set symbol " [env][$SHLVL] \$ "
        #' [guix]$ '
        set -l color $fish_color_cwd
        echo -n $USER@$hostname
        set_color $color
        echo -n (prompt_pwd)
        set_color normal
        echo -n $symbol
    else if test -n "$GUIX_PROFILE"; and test "$GUIX_PROFILE" != "/home/jet/.guix-profile"
        set symbol " [env][$SHLVL] \$ "
        #' [guix]$ '
        set -l color $fish_color_cwd
        echo -n $USER@$hostname
        set_color $color
        echo -n (prompt_pwd)
        set_color normal
        echo -n $symbol
    else
        set -l symbol ' $ '
        set -l color $fish_color_cwd
	set_color "cyan"
	echo -n $USER
	set_color "white"
	echo -n @$hostname
	set_color $color
        echo -n (prompt_pwd)
        set_color normal
        echo -n $symbol
    end
end
