#!/bin/bash

battery=$(find /sys/class/power_supply -name "BAT*" | head -n 1)

if [ -n battery ]; then
    while true; do
        battery_capacity=$(cat $battery/capacity)

        if [ "$battery_capacity" -lt 10 ]; then
            notify-send "Low Battery Warning" "Battery level is below 10% ($battery_capacity%)"
        fi

        sleep 120
    done
fi
