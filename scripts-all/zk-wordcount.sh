#!/usr/bin/env fish
zk list --format '{{word-count}}\t{{title}}' --sort word-count --limit 20
