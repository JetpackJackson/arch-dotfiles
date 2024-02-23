#!/usr/bin/env python

import sys

filename = sys.argv[1]
with open(filename, 'r') as file:
  filedata = file.read()

string2 = '/school/'+sys.argv[2]+'/'

filedata = filedata.replace('/notes-zettelkasten/fleeting/', string2)

with open(filename, 'w') as file:
  file.write(filedata)
