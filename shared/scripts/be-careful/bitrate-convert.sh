#!/bin/bash
#for i in *.zip; do cp -r "$i" "${i%.*}.zip"; done
#for i in *.mp3; do ffmpeg -i "$i" -b:a 128k "${i%.*}_(1).mp3"; done
#for i in *.mp3; do ffmpeg -i "$i" -c:a libopus -b:a 96k "${i%.*}.opus"; done
for f in *.mp3; do
ffmpeg -i "$f" -vn -c:a libopus -b:a 64k "${f}_64k.ogg"
ffmpeg -i "$f" -vn -c:a libopus -b:a 80k "${f}_80k.ogg"
ffmpeg -i "$f" -vn -c:a libopus -b:a 96k "${f}_96k.ogg"
ffmpeg -i "$f" -vn -c:a libopus -b:a 128k "${f}_128k.ogg"
done
