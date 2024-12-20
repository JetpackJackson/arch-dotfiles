#!/usr/bin/env bash

/home/jet/docs/pip-stuff/pip-beet/bin/beet up
/home/jet/docs/pip-stuff/pip-beet/bin/beet splupdate
cp ~/music/playlists/everything.m3u ~/music-android/playlists/everything.m3u
cp ~/music/playlists/deutschemusik.m3u ~/music-android/playlists/deutschemusik.m3u
sed -i -e 's/^/\/storage\/emulated\/0\/Music\//' ~/music-android/playlists/deutschemusik.m3u
sed -i -e 's/^/\/storage\/emulated\/0\/Music\//' ~/music-android/playlists/everything.m3u

beet convert -y 'artist::^Cro$'
beet convert -y "artist::^Lotte$"
beet convert -y 'artist::^LOTTE$'
beet convert -y 'artist::^Love A$'
beet convert -y 'artist:^Marv$'
beet convert -y 'artist:Phil Collins' 'fremde'
beet convert -y 'artist:David Bowie' 'helden'

awk -F '/' '{ print $2 }' < ~/music/playlists/deutschemusik.m3u | sort | uniq > /tmp/deutsch.txt
sed -i '/LOTTE/d' /tmp/deutsch.txt
sed -i '/Cro/d' /tmp/deutsch.txt
sed -i '/Love A/d' /tmp/deutsch.txt
sed -i '/Marv/d' /tmp/deutsch.txt
sed -i '/Phil Collins/d' /tmp/deutsch.txt
sed -i '/David Bowie/d' /tmp/deutsch.txt
while read -r artist; do
    echo "converting $artist"
    beet convert -y "artist:$artist"
    beet convert -y "albumartist:$artist"
done < /tmp/deutsch.txt
awk -F '/' '{ print $2 }' < ~/music/playlists/aufenglisch.m3u | sort | uniq > /tmp/auf.txt
while read -r artist; do
    beet convert -y "artist:$artist"
done < /tmp/auf.txt

#/home/jet/docs/pip-stuff/pip-beet/bin/beet alt update droid

# lrc files
find ~/music/ -name "*.lrc" -printf '%P\n' > /tmp/lrc-all.txt
true > /tmp/lrc.txt
while read -r file; do
    newfile=${file/%.*/.lrc}
    if [ -f "/home/jet/music/./$newfile" ];
    then
        echo $newfile >> /tmp/lrc.txt
    fi
done < ~/music/playlists/deutschemusik.m3u
rsync -aAXHvu $1 --delete --relative --files-from=/tmp/lrc.txt /home/jet/music/./ ~/music-android/
