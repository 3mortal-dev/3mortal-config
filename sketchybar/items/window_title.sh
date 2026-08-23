#!/bin/bash

sketchybar --add item window_title center \
    --set window_title \
        icon="􀏝" \
        icon.color=$DIM_COLOR \
        icon.padding_right=4 \
        label.font="SF Pro:Semibold:13.0" \
        label.color=$WHITE \
        label.max_chars=44 \
        background.drawing=off \
        update_freq=2 \
        script="$PLUGIN_DIR/window_title.sh" \
    --subscribe window_title aerospace_workspace_change front_app_switched
