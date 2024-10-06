#!/bin/bash
#for i in *.zip; do cp -r "$i" "${i%.*}.zip"; done
#for i in *.mp3; do ffmpeg -i "$i" -b:a 128k "${i%.*}_(1).mp3"; done
for i in *.webm; do ffmpeg -i "$i" -vn -ab 128k -ar 44100 "${i%.*}.mp3"; done
