#!/bin/bash

# Get current layout from hyprctl
get_layout() {
    hyprctl devices | grep -B 5 "main: yes" | grep "active keymap:" | sed 's/.*active keymap: //'
}

# Get keyboard name (first line before main: yes block)
get_keyboard() {
    hyprctl devices | grep -B 6 "main: yes" | head -1 | tr -d '\t'
}

# Switch to next layout
switch_layout() {
    local kb=$(get_keyboard)
    if [[ -n "$kb" ]]; then
        hyprctl switchxkblayout "$kb" next >/dev/null 2>&1
    fi
}

case "$1" in
    --next)
        switch_layout
        ;;
    *)
        layout=$(get_layout)
        case "$layout" in
            *English*|*US*) echo "EN" ;;
            *Ukrainian*) echo "UA" ;;
            *) echo "${layout:0:2}" ;;
        esac
        ;;
esac
