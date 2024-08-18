#!/bin/bash

rsync -avxHAXP --exclude '.git*' .* ~/ # add --delete flag

sudo cp etc/lemurs/wayland/hyprland /etc/lemurs/wayland/hyprland

