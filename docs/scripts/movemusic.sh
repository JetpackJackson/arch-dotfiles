#!/usr/bin/env bash

for f in *.opus; do
#    name=`echo "$f"|sed 's/ -.*//'`
#    letter=`echo "$name"|cut -c1`
    test=$(ffprobe -v 0 -show_entries tags=ARTIST -of default=nw=1:nk=1 -i "$f")
    album=$(ffprobe -v 0 -show_entries tags=ALBUM -of default=nw=1:nk=1 -i "$f")
    dir="DestinationDirectory/$test/$album"
    mkdir -p "$dir"
    mv "$f" "$dir"
done

for f in *.mp3; do
    name=`echo "$f"|sed 's/ -.*//'`
    letter=`echo "$name"|cut -c1`
    test=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$f")
    album=$(ffprobe -loglevel error -show_entries format_tags=album -of default=noprint_wrappers=1:nokey=1 "$f")
    dir="DestinationDirectory/$test/$album"
    mkdir -p "$dir"
    mv "$f" "$dir"
done
