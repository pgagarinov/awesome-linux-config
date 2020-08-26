#!/bin/sh
set -e
sudo pacman -S --noconfirm --needed aspell-en libmythes mythes-en languagetool aspell-ru 
yay -S --noconfirm --needed hunspell-ru
