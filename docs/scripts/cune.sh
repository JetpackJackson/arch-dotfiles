#!/usr/bin/env bash

# requires cuneiform
path="$XDG_PICTURES_DIR"/screenshots/
file=$(ls "$path" | tail -n1)

cuneiform -o cune.py "$path""$file"
