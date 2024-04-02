sudo pacman -S hyprland, pipewire pipewire-pulse pipewire-jack, pavucontrol, xdg-utils, alacritty, openssh, tmux, starship, rsync, firefox, less, neovim, unzip, wl-clipboard, zsh

#---------------Tmux pluggin manager---------------
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#-----------------------Yay------------------------
pushd /home/$(whoami)/
git clone https://aur.archlinux.org/yay.git
makepkg -si
popd

#------------------Other packages------------------
yay -S visual-studio-code-bin
