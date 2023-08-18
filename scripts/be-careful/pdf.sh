#!/bin/bash
for f in *.docx
do
lowriter --headless --convert-to pdf "$f"
done
