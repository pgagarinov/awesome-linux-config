#!/bin/zsh
set -e
full_path=$(realpath $0)
dir_path=$(dirname $full_path)

setopt +o nomatch
rm -rf ~/.oh-my-zsh
rm -rf ~/.fzf*
rm -rf  ~/.zshrc*
rm -f ~/.p10k.zsh
rm -f ~/.shell.pre-oh-my-zsh
rm -rf ~/.cache/p10k*

export ZSH_CUSTOM=~/.oh-my-zsh/custom
#sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM}/plugins/fzf-tab
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions

cp $dir_path/config/.zshrc ~
cp $dir_path/config/.p10k.zsh ~


