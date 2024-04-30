sudo pacman -S hyprland pipewire pipewire-pulse pipewire-jack pavucontrol xdg-utils alacritty openssh tmux starship rsync firefox less neovim unzip wl-clipboard zsh nodejs npm tree wget bluez blueman gdb bear nwg-look htop ripgrep

#---------------Tmux pluggin manager---------------
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#-----------------------Yay------------------------
# Needs fixing
pushd /home/$(whoami)/
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
popd
#-----------------Adoptium JDK---------------------
# sudo archlinux-java status

#------------------Other packages------------------
yay -S visual-studio-code-bin webcord postman-bin catppuccin-gtk-theme-mocha catppuccin-cursors-mocha dunst

sudo pacman -S gradle
