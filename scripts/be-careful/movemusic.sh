#!/bin/bash

for f in *.mp3; do
    name=`echo "$f"|sed 's/ -.*//'`
    letter=`echo "$name"|cut -c1`
    test=$(ffprobe -loglevel error -show_entries format_tags=artist -of default=noprint_wrappers=1:nokey=1 "$f")
    album=$(ffprobe -loglevel error -show_entries format_tags=album -of default=noprint_wrappers=1:nokey=1 "$f")
    dir="DestinationDirectory/$test/$album"
    mkdir -p "$dir"
    mv "$f" "$dir"
done
