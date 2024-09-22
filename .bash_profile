export UNISON="$XDG_DATA_HOME/unison"
export MINETEST_USER_PATH="$XDG_DATA_HOME/minetest"
export HIST_FILE=$XDG_DOCUMENTS_DIR/sway-launcher-desktop-history.txt
#librewolf on wayland (0 is off)
export MOZ_ENABLE_WAYLAND=1
#fzf preview
export FZF_PREVIEW_LINES=48
export FZF_PREVIEW_COLUMNS=88
export FZF_DEFAULT_COMMAND="ls -r -1"
export FZF_DEFAULT_OPTS="--color=bg+:#33353f,bg:#2c2e34,border:#7f8490,spinner:#b39df3,hl:#7f8490,fg:#e2e2e3,header:#7f8490,info:#fc5d7c,pointer:#fc5d7c,marker:#fc5d7c,fg+:#e2e2e3,preview-bg:#363944,prompt:#fc5d7c,hl+:#fc5d7c"
# fixes
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive
export W3M_DIR=$XDG_STATE_HOME/w3m
export CARGO_HOME=$XDG_DATA_HOME/cargo
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
#set -gx _JAVA_OPTIONS $XDG_CONFIG_HOME/java
#set -gx _JAVA_OPTIONS -Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java -Djavafx.cachedir=$XDG_CACHE_HOME/openjfx"
export JAVA_HOME=/usr/lib/jvm/java-22-openjdk/
export ANDROID_HOME=$XDG_DATA_HOME/android-studio/
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export WINEPREFIX=$XDG_DATA_HOME/wine
export QT_QPA_PLATFORM="wayland;xcb"
export TERMINAL_COMMAND=foot
export EDITOR="emacstest.sh"
# figure out emacs diffprog?
export DIFFPROG="nvim -d"
export HISTFILE=$XDG_STATE_HOME/bash/history
export XCOMPOSEFILE=$XDG_CONFIG_HOME/X11/xcompose
export XINITRC=$XDG_CONFIG_HOME/X11/xinitrc
export XAUTHORITY=$XDG_RUNTIME_DIR/Xauthority
export GNUPGHOME=$HOME/.gnupg
export ANKI_BASE=$XDG_DATA_HOME/AnkiData
export GEM_HOME=$XDG_DATA_HOME/gem/ruby
export BUNDLE_USER_CONFIG=$XDG_CONFIG_HOME/bundle/
export BUNDLE_USER_CACHE=$XDG_CACHE_HOME/bundle
export BUNDLE_USER_PLUGIN=$XDG_DATA_HOME/bundle
export NUGET_PACKAGES=$XDG_CACHE_HOME/NuGetPackages
export DOTNET_CLI_HOME=$XDG_DATA_HOME/dotnet
export GOPATH=$XDG_DATA_HOME/go
export PLATFORMIO_CORE_DIR=$XDG_DATA_HOME/platformio
export MBSYNCRC=$XDG_CONFIG_HOME/isync/mbsyncrc
export PATH="/home/jet/docs/scripts/:/home/jet/.local/bin/:/usr/lib/jvm/java-22-openjdk/bin/:$PATH"
