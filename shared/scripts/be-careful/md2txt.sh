#!/bin/bash
for i in *.md; do cp -r "$i" "${i%.*}.txt"; done
