#!/bin/bash
myvar="$PWD"
mkdir "copies-$1"
find . -name "Copy*.$1" -exec mv {} "$myvar"/"copies-$1"/ \;
find . -name "*(*).$1" -exec mv {} "$myvar"/"copies-$1"/ \;
find . -name "*.$1.~1~" -exec mv {} "$myvar"/"copies-$1"/ \;
