#!/bin/bash
# Cycles through occupied workspaces + 1 empty on current monitor
# Usage: workspace-cycle.sh next|prev

direction="$1"

# Get current monitor and workspace
current_monitor=$(hyprctl activeworkspace -j | jq -r '.monitor')
current_ws=$(hyprctl activeworkspace -j | jq -r '.id')

# Get occupied workspaces on current monitor (sorted)
mapfile -t ws_list < <(hyprctl workspaces -j | jq -r --arg mon "$current_monitor" \
    '[.[] | select(.monitor == $mon and .windows > 0) | .id] | sort | .[]')

# Add next empty workspace (max + 1)
if [[ ${#ws_list[@]} -gt 0 ]]; then
    max_ws=${ws_list[-1]}
    empty_ws=$((max_ws + 1))
else
    empty_ws=1
fi
ws_list+=("$empty_ws")

# Find current position and switch
len=${#ws_list[@]}

current_idx=-1
for i in "${!ws_list[@]}"; do
    if [[ "${ws_list[$i]}" -eq "$current_ws" ]]; then
        current_idx=$i
        break
    fi
done

# If current workspace not in list, go to first
if [[ $current_idx -eq -1 ]]; then
    hyprctl dispatch workspace "${ws_list[0]}"
    exit 0
fi

if [[ "$direction" == "next" ]]; then
    next_idx=$(( (current_idx + 1) % len ))
else
    next_idx=$(( (current_idx - 1 + len) % len ))
fi

hyprctl dispatch workspace "${ws_list[$next_idx]}"
