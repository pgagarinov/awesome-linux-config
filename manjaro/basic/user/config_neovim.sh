#!/bin/bash
set -e
rm -rf ~/.config/nvim
full_path=$(realpath $0)
dir_path=$(dirname $full_path)
cp -r $dir_path/config/.config/nvim ~/.config
nvim --headless  +PlugInstall +"CocInstall coc-rls" +qa
