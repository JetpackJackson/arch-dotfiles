#!/usr/bin/env sh

cd /home/jet/music/
find . -type f -printf '%P\n' > ~/everything.m3u

while read -r line
do
    grep -w -- "$line" ~/everything.m3u >> ~/deutschemusik.m3u
done < ~/docs/scripts/bands.txt

while read -r line
do
    grep -w -- "$line" ~/everything.m3u >> ~/belafarinrod.m3u
done < ~/docs/scripts/aerzte.txt

cd /home/jet/music/playlists/
rm everything.m3u
rm belafarinrod.m3u
rm deutschemusik.m3u
mv ~/everything.m3u ~/music/playlists/everything.m3u
mv ~/belafarinrod.m3u ~/music/playlists/belafarinrod.m3u
mv ~/deutschemusik.m3u ~/music/playlists/deutschemusik.m3u
