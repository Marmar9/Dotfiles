#!/bin/bash

sudo pacman -Syu
# Install apps
sudo pacman -S hyprland pipewire pipewire-pulse pipewire-jack pavucontrol xdg-utils alacritty tmux starship rsync firefox less neovim unzip wl-clipboard zsh tree bluez blueman nwg-look htop ripgrep wofi lemurs --noconfirm


#---------------Tmux pluggin manager---------------
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#-----------------------Yay------------------------

mkdir /tmp/yay
cd /tmp/yay
curl -OJ 'https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=yay'
makepkg -si --noconfirm
cd /home/marcin/Dotfiles/
rm -rf /tmp/yay

#-----------------Adoptium JDK---------------------
yay -S jdk21-temurin21.0.4.u7-1

# sudo archlinux-java status

#------------------Other packages------------------
yay -S  webcord catppuccin-gtk-theme-mocha catppuccin-cursors-mocha dunst --noconfirm
