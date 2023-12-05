if status is-interactive
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

set -gx LS_COLORS 'rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=36;40:ow=37;40:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.swp=00;90:*.tmp=00;90:*.dpkg-dist=00;90:*.dpkg-old=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90'

#librewolf on wayland (0 is off)
set -gx MOZ_ENABLE_WAYLAND 1

#neofetch shows fish shell
set -gx SHELL /usr/bin/fish

#fzf preview
set -gx FZF_PREVIEW_LINES 48
set -gx FZF_PREVIEW_COLUMNS 88
set -gx FZF_DEFAULT_COMMAND "ls -r -1"

# zk and projects
set -gx ZK_NOTEBOOK_DIR "$XDG_DOCUMENTS_DIR/notes/notes-zettelkasten"
set -gx ZETTELKASTEN "$XDG_DOCUMENTS_DIR/notes/notes-zettelkasten"
set -gx PROJECTS "$XDG_DOCUMENTS_DIR/notes/projects"
set -gx SCRIPTS "$XDG_DOCUMENTS_DIR/scripts"

# fixes
set -gx W3M_DIR $XDG_STATE_HOME/w3m
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx TEXMFVAR $XDG_CACHE_HOME/texlive/texmf-var
#set -gx _JAVA_OPTIONS $XDG_CONFIG_HOME/java
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


# lang
set -gx LANG de_DE.utf8
set -gx LC_MESSAGES en_US.utf8
set -gx LC_ALL de_DE.utf8

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
set -gx PATH /home/jet/docs/scripts:/home/jet/.local/bin:/home/jet/.local/share/cargo/bin:/home/jet/.local/bin/cli-wordle:/home/jet/.local/share/gem/ruby/3.0.0/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/home/jet/.dotnet/tools:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
