#!/bin/bash
rename -v$2 "Copy of " "" *
for i in *.$1; do mv "$i" "${i%.*}_(1).$1"; done
