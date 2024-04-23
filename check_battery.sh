#!/bin/bash

while true; do
    battery_capacity=$(cat /sys/class/power_supply/BAT0/capacity)

    if [ "$battery_capacity" -lt 10 ]; then
        notify-send "Low Battery Warning" "Battery level is below 10% ($battery_capacity%)"
    fi

    sleep 120
done

