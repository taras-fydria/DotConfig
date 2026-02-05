#!/bin/bash
hyprctl switchxkblayout all next
layout=$(~/.config/waybar/scripts/language.sh)

gdbus call --session \
  --dest=org.freedesktop.Notifications \
  --object-path=/org/freedesktop/Notifications \
  --method=org.freedesktop.Notifications.Notify \
  "keyboard-layout" 0 "" "$layout" "" '[]' \
  '{"suppress-sound": <true>, "transient": <true>}' 1500 > /dev/null
