#!/bin/bash

sudo ln -sf /usr/bin/nvim /usr/bin/v
sudo ln -sf /usr/bin/nvim /usr/bin/vi

mkdir /home/marcin/.local/share/fonts/ 
(cd /home/marcin/.local/share/fonts/ && sudo curl -OL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/Lilex.zip && sudo unzip Lilex.zip && sudo rm README.md Lilex.zip LICENSE.txt )

