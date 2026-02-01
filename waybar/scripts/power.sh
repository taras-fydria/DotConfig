#!/bin/bash

options="  Lock\n  Logout\n  Suspend\n  Reboot\n  Shutdown"

selected=$(echo -e "$options" | wofi --dmenu -i -p "Power" --width 200 --height 220)

case "$selected" in
    *Lock)
        hyprlock
        ;;
    *Logout)
        hyprctl dispatch exit
        ;;
    *Suspend)
        systemctl suspend
        ;;
    *Reboot)
        systemctl reboot
        ;;
    *Shutdown)
        systemctl poweroff
        ;;
esac
