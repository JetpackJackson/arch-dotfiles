#!/bin/bash

for f in *.mp3; do
    name=`echo "$f"|sed 's/ -.*//'`
    letter=`echo "$name"|cut -c1`
#    dir="DestinationDirectory/$letter/$name"
    dir="DestinationDirectory/$name"
    mkdir -p "$dir"
    mv "$f" "$dir"
done
