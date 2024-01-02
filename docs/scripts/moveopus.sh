#!/bin/bash

for f in *.opus; do
#    name=`echo "$f"|sed 's/ -.*//'`
#    letter=`echo "$name"|cut -c1`
    test=$(ffprobe -v 0 -show_entries tags=ARTIST -of default=nw=1:nk=1 -i "$f")
    album=$(ffprobe -v 0 -show_entries tags=ALBUM -of default=nw=1:nk=1 -i "$f")
    dir="DestinationDirectory/$test/$album"
    mkdir -p "$dir"
    mv "$f" "$dir"
done
