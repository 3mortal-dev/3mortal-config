#!/usr/bin/env bash

sketchybar --add item keyboard right \
    --set keyboard \
        icon.drawing=off \
        label.font="SF Pro:Bold:13.0" \
        label.color=$WHITE \
        background.color=$ITEM_BG_COLOR \
        background.drawing=on \
        update_freq=1 \
        script="$PLUGIN_DIR/keyboard.sh" \
    --subscribe keyboard system_woke
