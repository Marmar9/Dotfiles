#!/bin/env bash
# This runs from $DOTFILES_HOME/config

if [ ! -f "$XDG_CONFIG_HOME/hypr/monitors.conf" ]; then
    # rm "$XDG_CONFIG_HOME/hypr/monitors.conf"
    height_sum=0
    
    hyprctl monitors -j | jq -r '.[] | "\(.name) \(.availableModes[0])"' | while read monitor mode; do
        height=$(echo $mode | sed -n "s/.\{0,\}x\([0-9]\{1,\}\)@.\{0,\}/\1/p")
        echo $height
        if [ $height = "1080" ]; then
            echo "monitor = $monitor, $mode, 0x-$height_sum, 1" >> $XDG_CONFIG_HOME/hypr/monitors.conf
        else
            echo "monitor = $monitor, $mode, 0x-$height_sum, 2" >> $XDG_CONFIG_HOME/hypr/monitors.conf
        fi
    
        height_sum=$(($height_sum + $height))
    done


fi

rsync ./ $XDG_CONFIG_HOME/
