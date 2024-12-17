#/bin/bash

rsync -avxHXP config/* ~/.config
sudo rsync -avxHXP etc/* /etc
