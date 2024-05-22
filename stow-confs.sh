#!/usr/bin/env bash
cd configs
stow -R . -t ~/.config/ -v
cd ..
cd arduino15
stow -R . -t ~/.arduino15/ -v
cd ..
cd scripts
stow -R . -t ~/docs/scripts/ -v
cd ..
cd others
#stow -R librewolf -t ~/.librewolf/ -v --simulate
