#!/bin/bash
#for i in *.zip; do cp -r "$i" "${i%.*}.zip"; done
for i in *.zip; do unzip "$i"; done
