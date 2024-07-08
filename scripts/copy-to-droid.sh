#!/usr/bin/env bash

beet up
beet splupdate
cp ~/music/playlists/everything.m3u ~/music-android/playlists/everything.m3u
cp ~/music/playlists/deutschemusik.m3u ~/music-android/playlists/deutschemusik.m3u
sed -i -e 's/^/\/storage\/emulated\/0\/Music\//' ~/music-android/playlists/deutschemusik.m3u
sed -i -e 's/^/\/storage\/emulated\/0\/Music\//' ~/music-android/playlists/everything.m3u

rsync -aAXHvu $1 --delete --relative --files-from=/home/jet/music/playlists/deutschemusik.m3u /home/jet/music/./ ~/music-android/
#find ~/music/ -name "*.lrc" -printf '%P\n' > /tmp/lrc.txt
#rsync -aAXHvu $1 --delete --relative --files-from=/tmp/lrc.txt /home/jet/music/./ ~/music-android/

find ~/music/ -name "*.lrc" -printf '%P\n' > /tmp/lrc-all.txt
true > /tmp/lrc.txt
while read -r file; do
    newfile=${file/%.*/.lrc}
    if [ -f "/home/jet/music/./$newfile" ];
    then
        echo $newfile >> /tmp/lrc.txt
    fi
done < ~/music/playlists/deutschemusik.m3u
#done < /tmp/lrc-all.txt
rsync -aAXHvu $1 --delete --relative --files-from=/tmp/lrc.txt /home/jet/music/./ ~/music-android/
rsync -aAXHvu $1 --delete --relative --files-from=/home/jet/music/playlists/aufenglisch.m3u /home/jet/music/./ ~/music-android/
