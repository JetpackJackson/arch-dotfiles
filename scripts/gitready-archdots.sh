#!/usr/bin/env bash

#true > /tmp/files-home.txt
# ignore
#echo "/home/" >> /tmp/files-home.txt
#echo "/home/jet/" >> /tmp/files-home.txt
#echo "/home/jet/docs/" >> /tmp/files-home.txt
#echo "/home/jet/docs/scripts/" >> /tmp/files-home.txt
#echo "/home/jet/.config/" >> /tmp/files-home.txt
#echo "./.git/" >> /tmp/files-home.txt
#cat ~/docs/notes/paclist/folders-home.txt >> /tmp/files-home.txt

#find .config/ -type d \( -name Cache -o -name Logs -o -name .stversions -o -name .stfolder \) -prune -o -type f -print | grep -F -f docs/notes/paclist/folders-home.txt >> /tmp/files-home.txt

#find .config/\
#    \( -name Cache -o -name Logs -o -name .stversions -o -name .stfolder -o -name mpdasrc -o -name database \)\
#    -prune\
#    -o -print |\
#    grep -F -f docs/notes/paclist/folders-home.txt |\
#    rsync -aAXHvu $1 --delete-missing-args --delete --files-from=- ~/ ~/docs/notes/projects/git/newdots/

#find .config/ -type f\
#    -not -path ".config/OpenTabletDriver/Cache/*"\
#    -not -path ".config/OpenTabletDriver/Logs/*"\
#    -not -path ".config/mpd/database"\
#    -not -path "*.stversions*"\
#    -not -path "*.stfolder*"\
#    -a\
#    \(\
#    -path ".config/beets/*"\
#    -o -path ".config/btop/*"\
#    -o -path ".config/czkawka/*"\
#    -o -path ".config/discord-rpc/*"\
#    -o -path ".config/efm-langserver/*"\
#    -o -path ".config/fish/*"\
#    -o -path ".config/kitty/*"\
#    -o -path ".config/lf/*"\
#    -o -path ".config/listenbrainz-mpd/*"\
#    -o -path ".config/mako/*"\
#    -o -path ".config/mpd/*"\
#    -o -path ".config/mpd/*"\
#    -o -path ".config/mpv/*"\
#    -o -path ".config/neofetch/*"\
#    -o -path ".config/newsboat/*"\
#    -o -path ".config/nvim/*"\
#    -o -path ".config/OpenTabletDriver/*"\
#    -o -path ".config/paru/*"\
#    -o -path ".config/pistol/*"\
#    -o -path ".config/pudb/*"\
#    -o -path ".config/swappy/*"\
#    -o -path ".config/sway/*"\
#    -o -path ".config/X11/*"\
#    -o -path ".config/yambar/*"\
#    -o -path ".config/zathura/*" \) -print |\
    #rsync -aAXHvu $1 --delete --files-from=- ~/ ~/sedtest/
    #rsync -aAXHvn --delete-excluded --include-from=/home/jet/docs/notes/paclist/include.txt /home/jet/.config/ /home/jet/sedtest/

    # | xargs -I cp -r '{}' ~/sedtest/ '{}'
    #-exec cp {} $HOME/docs/notes/projects/git/newdots/ \;
    #grep -F -f docs/notes/paclist/folders-home.txt |\
    #
# bad
#rsync -aAXHv --files-from=<(find .config/ \( -name Cache -o -name Logs -o -name .stversions -o -name .stfolder -o -name mpdasrc -o -name database \) -prune -o -print | grep -F -f docs/notes/paclist/folders-home.txt) ./ ~/sedtest/
#rsync -aAXHvun --delete --ignore-existing --include-from=<(find .config/\
#    \( -name Cache -o -name Logs -o -name .stversions -o -name .stfolder -o -name mpdasrc -o -name database \)\
#    -prune\
#    -o -print |\
#    grep -F -f docs/notes/paclist/folders-home.txt) --exclude='*' ./ ~/sedtest/
    

###find docs/scripts/ -type f -print >> /tmp/files-home.txt
###sed -i -e '/mpdasrc/d' /tmp/files-home.txt
###sed -i -e '/Cache/d' /tmp/files-home.txt
###sed -i -e '/.stversions/d' /tmp/files-home.txt
###sed -i -e '/.stfolder/d' /tmp/files-home.txt
###sed -i -e '/Logs/d' /tmp/files-home.txt
###sed -i -e '/database/d' /tmp/files-home.txt
####misery
####rsync -aAXHvu $1 --delete-excluded --include-from=/tmp/files-home.txt --exclude='*' /home/jet/ /home/jet/docs/notes/projects/git/newdots/
###
#### copy .config and scripts but doesn't delete the files
###rsync -aAXHvu $1 --delete-missing-args --delete --files-from=/tmp/files-home.txt /home/jet/ /home/jet/docs/notes/projects/git/newdots/
####rsync -aAXHvu $1 --delete --include-from=/tmp/files-home.txt /home/jet/ /home/jet/docs/notes/projects/git/newdots/
###
#### copy a few etc files
###rsync -aAXHvu $1 --delete --files-from=/home/jet/docs/notes/paclist/folders-etc.txt /etc/ /home/jet/docs/notes/projects/git/newdots/etc/
###
#### try to make it prune before copy??
####find docs/scripts/ -type d \( -name .stversions -o -name .stfolder \) -prune -o -type f -print| rsync -aAXHvu $1 --delete /home/jet/docs/scripts/ /home/jet/docs/notes/projects/git/newdots/
###
#### wallpaper
###rsync -aAXHvu $1 --delete $XDG_PICTURES_DIR/wallpapers/fox.jpg $PROJECTS/git/newdots/pics/wallpapers/fox.jpg
####cd $PROJECTS/git/newdots
