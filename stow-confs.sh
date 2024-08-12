#!/usr/bin/env bash
cd configs || exit
stow -R . -t ~/.config/ -v
cd ..
cd arduino15 || exit
stow -R . -t ~/.arduino15/ -v
cd ..
cd scripts || exit
stow -R . -t ~/docs/scripts/ -v
cd ..
cd others || exit
stow -R . -t ~/.local/share/ -v 
cd ..
cd configs/lisgd-0.4.0 || exit
make
killall lisgd
cp lisgd ~/.local/bin/lisgd
lisgd &
