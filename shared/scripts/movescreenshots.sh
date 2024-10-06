#!/usr/bin/env bash
screenshots=$XDG_PICTURES_DIR/screenshots/
dir=$1
cd $screenshots
mkdir $dir

find $screenshots -printf '%P\n' | grep "swappy-$dir" | while IFS= read -r line; do
    echo "$line"
    mv "$line" "$dir"/"$line"
done

find $screenshots -printf '%P\n' | grep "primary_$dir" | while IFS= read -r line; do
    echo "$line"
    mv "$line" "$dir"/"$line"
done

find $screenshots -printf '%P\n' | grep "ps_$dir" | while IFS= read -r line; do
    echo "$line"
    mv "$line" "$dir"/"$line"
done
