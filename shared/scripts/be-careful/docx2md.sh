#!/bin/bash
for i in *.docx; do docx2txt "$i"; done
sleep 2
for i in *.txt; do cp -r "$i" "${i%.*}.md"; done
