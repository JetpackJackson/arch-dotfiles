#!/bin/bash
for i in *.eml; do
	munpack -t "$i"
	mv part1 "$i".html;
done
#filename=$(basename "$1" .eml)
#echo $filename
