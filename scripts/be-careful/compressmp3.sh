#!/bin/bash
#for i in *.zip; do cp -r "$i" "${i%.*}.zip"; done
for i in *.mp3; do ffmpeg -i "$i" -b:a 128k "${i%.*}_(1).mp3"; done
