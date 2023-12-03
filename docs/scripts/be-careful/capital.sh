#!/bin/bash

for i in *.mp3; do j="${i%.mp3}"; mv "$i" "${j^^}.mp3"; done
#for f in *.mp3 ; do mv -- "$f" "$(tr [:lower:] [:upper:] <<< "$f.mp3")" ; done


