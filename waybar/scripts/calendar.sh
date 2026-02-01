#!/usr/bin/env bash
set -euo pipefail

kitty --class waybar-calendar -T Calendar -e bash -lc '
cal -3
echo
date "+%A, %d %B %Y"
echo
echo "Press any key..."
read -n 1
'

