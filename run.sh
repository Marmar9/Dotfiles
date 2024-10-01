#!/bin/bash
source ./install.sh

source ./setup.sh
source ./sync.sh

# Change default shell to zsh

chsh -s /usr/bin/zsh

# Setup cups

# sudo systemctl enable --now cups

sudo usermod -aG lp $(whoami)
