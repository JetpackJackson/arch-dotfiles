if status is-login
    fish_add_path /home/jet/.config/guix/current/bin/ /home/jet/.guix-profile/bin/ /home/jet/docs/scripts/ /home/jet/.local/bin/ /home/jet/.local/share/cargo/bin/ /home/jet/.local/state/nix/profile/bin/ /nix/var/nix/profiles/default/bin/ /usr/lib/jvm/java-22-openjdk/bin/

    set -gx GUIX_PROFILE /home/jet/.guix-profile
    set -gx GUILE_LOAD_PATH /home/jet/.guix-profile/share/guile/site/3.0/
    #set -gx GUILE_LOAD_COMPILED_PATH home/jet/.guix-profile/lib/guile/3.0/site-ccache
    set -gx GUILE_LOAD_COMPILED_PATH /home/jet/.guix-profile/lib/guile/3.0/site-ccache:/home/jet/.guix-profile/share/guile/site/3.0
    set -gx GUIX_LOCPATH /home/jet/.guix-profile/lib/locale

    set -gx SSL_CERT_DIR $HOME/.guix-profile/etc/ssl/certs
    set -gx SSL_CERT_FILE $HOME/.guix-profile/etc/ssl/certs/ca-certificates.crt
    set -gx GIT_SSL_CAINFO $SSL_CERT_FILE

    #set -gx SSH_AGENT_PID ""
    #set -gx SSH_AUTH_SOCK $(gpgconf --list-dirs agent-ssh-socket)
    set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket

    # lang
    #set -gx LANG de_DE.UTF-8
    ##set -gx LANG en_US.UTF-8
    #set -gx LANGUAGE de_DE.UTF-8
    ##set -gx LC_ALL en_US.utf8
    #set -gx LC_MESSAGES en_US.UTF-8

    # home dir
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_DESKTOP_DIR $HOME/desk
    set -gx XDG_DOWNLOAD_DIR $HOME/dl
    #XDG_TEMPLATES_DIR "$HOME/"
    #XDG_PUBLICSHARE_DIR "$HOME/"
    set -gx XDG_DOCUMENTS_DIR $HOME/docs
    set -gx XDG_MUSIC_DIR $HOME/music
    set -gx XDG_PICTURES_DIR $HOME/pics
    set -gx XDG_VIDEOS_DIR $HOME/vids
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state

    set -gx WALLPAPER_DIR $XDG_PICTURES_DIR/wallpapers
    set -gx SCREENSHOT_DIR $XDG_PICTURES_DIR/screenshots

    # launch sway as part of autologin process
    # https://wiki.archlinux.org/title/Fish#Start_X_at_login
    if test -z "$DISPLAY" -a "$XDG_VTNR" = 1 -a "$hostname" = "sharky"
        set -gx HIST_FILE $XDG_DOCUMENTS_DIR/sway-launcher-desktop-history.txt
        set -gx SDL_VIDEODRIVER wayland
        set -gx _JAVA_AWT_WM_NONREPARENTING 1
       	set -gx XDG_CURRENT_DESKTOP sway
        set -gx XDG_SESSION_DESKTOP sway
        dbus-run-session sway -c $XDG_CONFIG_HOME/sway/config-$(cat /etc/hostname)
    end
end



if status is-interactive
    set -gx UNISON "$XDG_DATA_HOME/unison"

    set -gx MINETEST_USER_PATH "$XDG_DATA_HOME/minetest"

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
    set -gx LOCALE_ARCHIVE /usr/lib/locale/locale-archive
    set -gx W3M_DIR $XDG_STATE_HOME/w3m
    set -gx CARGO_HOME $XDG_DATA_HOME/cargo
    set -gx TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var
    #set -gx _JAVA_OPTIONS $XDG_CONFIG_HOME/java
    #set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
    set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx
    set -gx JAVA_HOME /usr/lib/jvm/java-22-openjdk/
    set -gx ANDROID_HOME $XDG_DATA_HOME/android-studio/
    set -gx GRADLE_USER_HOME $XDG_DATA_HOME/gradle
    set -gx WINEPREFIX $XDG_DATA_HOME/wine
    set -gx QT_QPA_PLATFORM "wayland;xcb"
    set -gx TERMINAL_COMMAND kitty
    # problem: does not show up in fastfetch
    #set -gx EDITOR "TERM=foot-direct emacsclient -nw"

    # This works. We use a fish script here to make sure that all env
    # vars are set up properly. A fish function doesn't get seen in
    # time so the function never gets called, so instead we use a
    # shebang and a normal script in my scripts folder which gets
    # added to $PATH.
    set -gx EDITOR "emacstest.sh"
    # FIXME
    set -gx DIFFPROG nvim pacdiff
    set -gx HISTFILE $XDG_STATE_HOME/bash/history
    set -gx XCOMPOSEFILE $XDG_CONFIG_HOME/X11/xcompose
    set -gx XINITRC $XDG_CONFIG_HOME/X11/xinitrc
    set -gx XAUTHORITY $XDG_RUNTIME_DIR/Xauthority
    set -gx GNUPGHOME $HOME/.gnupg
    set -gx ANKI_BASE $XDG_DATA_HOME/AnkiData
    set -gx GEM_HOME $XDG_DATA_HOME/gem/ruby
    set -gx BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle/
    set -gx BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundle
    set -gx BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundle
    set -gx NUGET_PACKAGES $XDG_CACHE_HOME/NuGetPackages
    set -gx DOTNET_CLI_HOME $XDG_DATA_HOME/dotnet
    set -gx GOPATH $XDG_DATA_HOME/go
    set -gx PLATFORMIO_CORE_DIR $XDG_DATA_HOME/platformio
    set -gx MBSYNCRC $XDG_CONFIG_HOME/isync/mbsyncrc

    abbr -a scu --set-cursor 'systemctl --user %' 
    abbr -a sc --set-cursor 'systemctl %' 

    abbr -a npi --set-cursor 'nix profile install nixpkgs#%'
    abbr -a ncg --set-cursor 'nix-collect-garbage%'
    abbr -a nps --set-cursor 'nix search nixpkgs %'
    abbr -a npl --set-cursor 'nix profile list%'
    abbr -a n --set-cursor 'nvim %'
    # workaround for emacs showing blue background on emacsclient startup with foot (emacs -nw w/TERM=foot is fine tho)
    # temp workaround, since it requires foot to be installed
    #abbr -a e --set-cursor 'TERM=foot-direct emacsclient -nw %'
    # no cmdline completion for cmdline args other than files but the
    # other option doesn't do that either
    abbr -a e --set-cursor 'emacsclient -c % &; disown'
    abbr -a en --set-cursor 'emacs -nw %'
    #abbr -a icat --set-cursor 'kitty +kitten icat %'

    abbr -a guix-listgen 'guix package --list-generations -p "$GUIX_PROFILE"'
    abbr -a guix-listin 'guix package --list-installed -p "$GUIX_PROFILE"'
    abbr -a guix-delgen --set-cursor 'guix package --delete-generations=% -p "$GUIX_PROFILE"'
    abbr -a guix-size 'guix size $(readlink -f $GUIX_PROFILE)'
    abbr -a guix-listpro 'guix package --list-profiles'

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
