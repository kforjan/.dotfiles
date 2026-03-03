#!/bin/bash

layout=$(hyprctl devices | grep -m1 "active keymap:" | sed 's/.*active keymap: //')

if [[ "$layout" == *"Croatian"* ]]; then
    echo "HR"
else
    echo "US"
fi
