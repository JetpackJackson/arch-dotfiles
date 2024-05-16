if status is-login
    fish_add_path /home/jet/.config/guix/current/ /home/jet/.guix-profile/bin/ /home/jet/docs/scripts/ /home/jet/.local/bin/ /home/jet/.local/share/cargo/bin/ /home/jet/.local/state/nix/profile/bin/ /nix/var/nix/profiles/default/bin/ /usr/lib/jvm/java-22-openjdk/bin/

    set -gx GUIX_PROFILE /home/jet/.guix-profile
    set -gx GUILE_LOAD_PATH /home/jet/.guix-profile/share/guile/site/3.0/
    #set -gx GUILE_LOAD_COMPILED_PATH home/jet/.guix-profile/lib/guile/3.0/site-ccache
    set -gx GUILE_LOAD_COMPILED_PATH /home/jet/.guix-profile/lib/guile/3.0/site-ccache:/home/jet/.guix-profile/share/guile/site/3.0
    set -gx GUIX_LOCPATH /home/jet/.guix-profile/lib/locale

    #    set -gx GUILE_LOAD_PATH "...:$HOME/.guix-profile/share/guile/site/3.0:$GUILE_LOAD_PATH"
    #    set -gx GUILE_LOAD_COMPILED_PATH "...:$HOME/.guix-profile/lib/guile/3.0/site-ccache:$GUILE_LOAD_COMPILED_PATH"


    #set -gx GUIX_PROFILE /home/jet/.guix-profile/

    # lang
    #set -gx LANG de_DE.utf8
    #set -gx LC_ALL de_DE.utf8
    set -gx LANG en_US.utf8
    set -gx LANGUAGE en_US.utf8
    #set -gx LC_ALL en_US.utf8
    set -gx LC_MESSAGES en_US.utf8

    # home dir
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_DESKTOP_DIR $HOME/desk
    set -gx XDG_DOWNLOAD_DIR $HOME/dl
    #XDG_TEMPLATES_DIR "$HOME/"
    #XDG_PUBLICSHARE_DIR "$HOME/"
    set -gx XDG_DOCUMENTS_DIR $HOME/docs
    #set -gx SCRIPTS_DIR $XDG_DOCUMENTS_DIR/scripts
    set -gx XDG_MUSIC_DIR $HOME/music
    set -gx XDG_PICTURES_DIR $HOME/pics
    set -gx WALLPAPER_DIR $XDG_PICTURES_DIR/wallpapers
    set -gx SCREENSHOT_DIR $XDG_PICTURES_DIR/screenshots
    set -gx XDG_VIDEOS_DIR $HOME/vids
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state
    #set -gx PATH /usr/local/texlive/2023/bin/x86_64-linux:/home/jet/docs/scripts:/home/jet/.local/bin:/home/jet/.local/share/cargo/bin:/home/jet/.nix-profile/bin:/home/jet/.local/state/nix/profile/bin:/nix/var/nix/profiles/default/bin:/home/jet/.local/share/gem/ruby/3.0.0/bin:/usr/lib/jvm/java-21-openjdk/bin/:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/jet/.dotnet/tools:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl

        #set -gx PATH $PATH ~/docs/scripts/ ~/.local/bin/ ~/.local/share/cargo/bin/ /home/jet/.local/state/nix/profile/bin/ /nix/var/nix/profiles/default/bin/ /usr/lib/jvm/java-22-openjdk/bin/
end



if status is-interactive



    set -gx HIST_FILE $XDG_DOCUMENTS_DIR/sway-launcher-desktop-history.txt
    set -gx LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=36;40:ow=37;40:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90'

    #librewolf on wayland (0 is off)
    set -gx MOZ_ENABLE_WAYLAND 1

    #neofetch shows fish shell
    set -gx SHELL /usr/bin/fish

    #fzf preview
    set -gx FZF_PREVIEW_LINES 48
    set -gx FZF_PREVIEW_COLUMNS 88
    set -gx FZF_DEFAULT_COMMAND "ls -r -1"
    set -gx FZF_DEFAULT_OPTS "--color=bg+:#33353f,bg:#2c2e34,border:#7f8490,spinner:#b39df3,hl:#7f8490,fg:#e2e2e3,header:#7f8490,info:#fc5d7c,pointer:#fc5d7c,marker:#fc5d7c,fg+:#e2e2e3,preview-bg:#363944,prompt:#fc5d7c,hl+:#fc5d7c"

    # zk and projects
    set -gx ZK_NOTEBOOK_DIR "$XDG_DOCUMENTS_DIR/notes/notes-zettelkasten"
    set -gx ZETTELKASTEN "$XDG_DOCUMENTS_DIR/notes/notes-zettelkasten"
    set -gx PROJECTS "$XDG_DOCUMENTS_DIR/notes/projects"
    set -gx SCRIPTS "$XDG_DOCUMENTS_DIR/scripts"

    # fixes
    #set -gx PAGER less
    set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive
    set -gx W3M_DIR $XDG_STATE_HOME/w3m
    set -gx CARGO_HOME $XDG_DATA_HOME/cargo
    set -gx TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var
    #set -gx _JAVA_OPTIONS $XDG_CONFIG_HOME/java
    #set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
    set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx
    set -gx JAVA_HOME /usr/lib/jvm/java-22-openjdk/
    #set -gx JAVA_HOME /usr/lib/jvm/java-21-openjdk/
    set -gx ANDROID_HOME $XDG_DATA_HOME/android-studio/
    set -gx GRADLE_USER_HOME $XDG_DATA_HOME/gradle
    set -gx WINEPREFIX $XDG_DATA_HOME/wine
    set -gx QT_QPA_PLATFORM "wayland;xcb"
    set -gx TERMINAL_COMMAND kitty
    set -gx EDITOR nvim
    set -gx DIFFPROG nvim pacdiff
    set -gx HISTFILE $XDG_STATE_HOME/bash/history
    set -gx XCOMPOSEFILE $XDG_CONFIG_HOME/X11/xcompose
    set -gx XINITRC $XDG_CONFIG_HOME/X11/xinitrc
    set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
    set -gx GNUPGHOME $XDG_DATA_HOME/gnupg
    set -gx ANKI_BASE $XDG_DATA_HOME/AnkiData
    set -gx GEM_HOME $XDG_DATA_HOME/gem/ruby
    set -gx BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle/
    set -gx BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
    set -gx BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle
    set -gx NUGET_PACKAGES $XDG_CACHE_HOME/NuGetPackages
    set -gx DOTNET_CLI_HOME $XDG_DATA_HOME/dotnet
    set -gx GOPATH $XDG_DATA_HOME/go

 
    abbr -a npi --set-cursor 'nix profile install nixpkgs#%'
    abbr -a ncg --set-cursor 'nix-collect-garbage%'
    abbr -a nps --set-cursor 'nix search nixpkgs %'
    abbr -a npl --set-cursor 'nix profile list%'
    abbr -a n --set-cursor 'nvim %'

    function gs --wraps='git status' --description 'alias git status'
        git status $argv
    end
    function gd --wraps='git diff' --description 'alias git diff'
        git diff $argv
    end
    function gco --wraps='git commit -m' --description 'alias git commit'
        git commit -m "$argv"
    end






    # list
    function la --wraps=ls --wraps='ls -Al' --description 'alias la=ls -Al'
        ls -Al $argv
    end
    # agenda
    function a --wraps='cd /home/jet/docs/notes/notes-zettelkasten && nvim agenda.md' --description 'alias a=cd /home/jet/docs/notes/notes-zettelkasten && nvim agenda.md'
        cd /home/jet/docs/notes/notes-zettelkasten && nvim agenda.md $argv
    end
    # list home dir stuff
    function lwc --wraps='ls -A | wc' --description 'alias lwc=ls -A | wc'
      ls -A | wc $argv
    end
    # old vscode stuff that I might need
    function vsc --wraps='vscodium --extensions-dir /home/jet/.local/share/vscode' --description 'alias vsc=vscodium --extensions-dir /home/jet/.local/share/vscode'
      vscodium --extensions-dir /home/jet/.local/share/vscode $argv
    end
    # music
    function queued --description 'alias queued=mpc queued'
      mpc queued $argv
    end
    # more music
    function skipto --wraps='mpc searchplay $1' --description 'alias skipto=mpc searchplay $1'
      mpc searchplay $1 $argv
    end

    function ard-up --wraps='arduino-cli compile -m $argv && arduino-cli upload && arduino-cli monitor' --description 'arduino stuff'
        arduino-cli compile -m $argv && arduino-cli upload && arduino-cli monitor
    end
    function ard-com --wraps='arduino-cli compile -m $argv' --description 'arduino stuff'
        arduino-cli compile -m $argv
    end
    function ard-lib1 --wraps='' --description 'arduino stuff'
        arduino-cli lib search $1 $argv | head -n10
    end
    function ard-libs --wraps='' --description 'arduino stuff'
        arduino-cli lib search $1 $argv | less
    end

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
        else
            set -l symbol ' $ '
            set -l color $fish_color_cwd
            echo -n $USER@$hostname
            set_color $color
            echo -n (prompt_pwd)
            set_color normal
            echo -n $symbol
        end
    end
    function fish_user_key_bindings
        fzf_key_bindings
    end
    # Change working dir in shell to last dir in lf on exit (adapted from ranger).
    function lf
        set tmp (mktemp)
        # `command` is needed in case `lfcd` is aliased to `lf`
        command lf -last-dir-path=$tmp $argv
        if test -f "$tmp"
            set dir (cat $tmp)
            rm -f $tmp
            if test -d "$dir"
                if test "$dir" != (pwd)
                    cd $dir
                end
            end
        end
    end
    #    function lf
    #        # `command` is needed in case `lfcd` is aliased to `lf`
    #        cd "$(command lf -print-last-dir "$argv")"
    #    end
    # Commands to run in interactive sessions can go here
end
# Emulates vim's cursor shape behavior
# Set the normal and visual mode cursors to a block
set fish_cursor_default block
# Set the insert mode cursor to a line
set fish_cursor_insert line
# Set the replace mode cursor to an underscore
set fish_cursor_replace_one underscore
# The following variable can be used to configure cursor shape in
# visual mode, but due to fish_cursor_default, is redundant here
set fish_cursor_visual block

set fish_vi_force_cursor 0

direnv hook fish | source
