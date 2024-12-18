#!/bin/bash

read -p "Do you want to install openrgb (type 'yes' for yes) : " openrgb

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
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#-----------------Adoptium JDK---------------------
yay -S jdk21-temurin21.0.4.u7-1

# sudo archlinux-java status

#------------------Other packages------------------

if [[ "$openrgb" = "yes" ]]; then
    sudo pacman -S i2c-tools --noconfirm 
    yay -S openrgb-git --noconfirm
fi

sudo usermod -aG lp $(whoami)

# Create dir for screenshots
mkdir /home/$(whoami)/screenshots

# Sync files
rsync -avxHXP config/* ~/.config
sudo rsync -avxHXP etc/* /etc
cp .zshrc ~/
cp .zshenv ~/


sudo locale-gen
chsh -s /usr/bin/zsh

# Cups for printer support
# sudo systemctl enable --now cups


# Install yazi plugins

ya pack -a dedukun/relative-motions
