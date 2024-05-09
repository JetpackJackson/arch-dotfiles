#!/usr/bin/env bash
part1=/home/jet/music/
part2=$(mpc -f %file% | head -n 1)
file=$part1$part2
ffmpeg -y -loglevel quiet -i "$file" -an -c:v copy /tmp/file.jpg &&
mpc -f "%artist% - %title% - %file%" current
kitty icat --align center --hold /tmp/file.jpg
kitty icat --clear
#rm /tmp/file.jpg
