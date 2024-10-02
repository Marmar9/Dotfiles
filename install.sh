#!/bin/bash

read -p "Do you want to install openrgb (type 'yes' for yes) : " openrgb

sudo pacman -Syu
# Install apps
sudo pacman -S hyprland pipewire pipewire-pulse pipewire-jack pulsemixer xdg-utils alacritty tmux starship rsync firefox less neovim unzip wl-clipboard zsh tree bluez blueman nwg-look qt5ct htop ripgrep wofi lemurs pass wezterm yazi hyprlock waybar cups --noconfirm


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
# -------------- Build dependencies ------------------

sudo pacman -S rust

#------------------Other packages------------------
yay -S  webcord catppuccin-gtk-theme-mocha catppuccin-cursors-mocha dunst wl-gammarelay-rs --noconfirm

if [[ "$openrgb" = "yes" ]]; then
    sudo pacman -S i2c-tools --noconfirm 
    yay -S openrgb-git --noconfirm
fi

# Cups for printer support
# sudo systemctl enable --now cups

sudo usermod -aG lp $(whoami)

# Imf not working at all yet
# sudo pacman -S fcitx-im

sudo cp etc/locale.gen etc/locale.conf /etc

sudo locale-gen
