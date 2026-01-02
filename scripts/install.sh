#!/bin/bash

#-----------------------Yay------------------------

mkdir /tmp/yay
cd /tmp/yay
curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
makepkg -si --noconfirm
cd /home/marcin/Dotfiles/
rm -rf /tmp/yay

sudo pacman -Syu

# Install apps

sudo yay -S --needed --noconfirm - < packages.txt

#---------------Tmux pluggin manager---------------
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#------------------Other packages------------------


read -p "Do you want to install openrgb (type 'yes' for yes) : " openrgb

if [[ "$openrgb" = "yes" ]]; then
    sudo pacman -S i2c-tools --noconfirm 
    yay -S openrgb-git --noconfirm
fi

sudo usermod -aG lp $(whoami)

# Create dir for screenshots
mkdir /home/$(whoami)/screenshots

sudo locale-gen

chsh -s /usr/bin/zsh

ya pack -a dedukun/relative-motions
