#!/usr/bin/env bash
HOSTNAME=$(cat /etc/hostname)
cd shared/configs || exit
stow -R . -t ~/.config/
cd ..
#cd arduino15 || exit
#stow -R . -t ~/.arduino15/
#cd ..
cd scripts || exit
stow -R . -t ~/docs/scripts/
cd ..
cd others || exit
stow -R . -t ~/.local/share/

cd ..
cd ..
cd host-$HOSTNAME || exit
cd configs || exit
stow -R . -t ~/.config/
if [[ $HOSTNAME = "weasel" ]] then
   #cd ..
   cd lisgd-0.4.0 || exit
   make
   killall lisgd
   cp lisgd ~/.local/bin/lisgd
   lisgd &
fi
