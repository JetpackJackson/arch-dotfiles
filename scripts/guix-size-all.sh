#!/usr/bin/env bash

profiles=$(guix package --list-profiles)
#while read -r line
while IFS= read -r line
do
    echo "$line"
    guix size $(readlink -f "$line") | tail -n1

done <<< $profiles

