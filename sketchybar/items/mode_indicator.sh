#!/usr/bin/env bash

# Custom event must be registered before anything can trigger/subscribe to
# it (learned this the hard way with aerospace_workspace_change earlier).
sketchybar --add event aerospace_mode_change

sketchybar --add item mode_indicator center \
    --set mode_indicator \
        drawing=off \
        icon.drawing=off \
        label="SERVICE MODE" \
        label.font="SF Pro:Bold:12.0" \
        label.color=$BAR_COLOR \
        background.color=$WARN_COLOR \
        background.drawing=on \
        background.corner_radius=6 \
        background.height=22 \
        script="$PLUGIN_DIR/mode_indicator.sh" \
    --subscribe mode_indicator aerospace_mode_change
