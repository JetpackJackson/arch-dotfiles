#!/usr/bin/env bash
cd configs
stow -R . -t ~/.config/ -v
cd ..
cd arduino15
stow -R . -t ~/.arduino15/ -v
cd ..
#cd etc
#sudo stow . -t /etc/ -v
