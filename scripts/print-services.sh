#!/usr/bin/env sh

find /etc/systemd -type l -exec test -f {} \; -print | awk -F'/' '{ printf ("%-40s | %s\n", $(NF-0), $(NF-1)) }' | sort -f
