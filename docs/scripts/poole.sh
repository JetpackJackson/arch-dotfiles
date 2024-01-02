#!/usr/bin/env bash
cd
cd $XDG_DOCUMENTS_DIR/notes/projects/BIOJEKYLL/
echo "1: Preview"
echo "2: Stop server"
echo "3: Build"
echo "4: Push to Neocities"
read choice
case "$choice" in
    1) jekyll serve -l & librewolf http://127.0.0.1:4000/
    ;;
    2) pkill -2 -f jekyll
        #-2 -f "/home/jet/.local/share/gem/ruby/bin/jekyll serve -l"
    ;;
    3) jekyll build
    ;;
    4) cd _site/
       neocities push --prune .
    ;;
    *) echo "Exiting."
    ;;
esac
