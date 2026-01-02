#!/bin/bash

monitors=$(hyprctl monitors -j | jq -r '.[] | .name')

tout_cmds=()
res_cmds=()

while read name; do
    tout_cmds+=("wlopm --off $name")
done < <(echo "$monitors")

while read name; do
    res_cmds+=("wlopm --on $name")
done < <(echo "$monitors")


swayidle -w timeout 10 "bash -c '$(IFS='; '; echo "${tout_cmds[*]}")'" resume "bash -c '$(IFS='; '; echo "${res_cmds[*]}")'" &

hyprlock && kill $!
