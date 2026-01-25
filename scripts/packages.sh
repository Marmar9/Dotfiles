#!/bin/bash

# Install packages from package list
sudo yay -Syyu
sudo yay -S --needed --noconfirm - < $HOME/dotfiles/packages.txt
