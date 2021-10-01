#!/bin/bash

ARR=()
ARR+=("Kill")

CHOICE=$(printf '%s\n' "${ARR[@]}" | rofi -dmenu -p "i3menu")

if [ "$CHOICE" = "Kill" ]; then
    i3-msg "kill"
    exit 0
fi
