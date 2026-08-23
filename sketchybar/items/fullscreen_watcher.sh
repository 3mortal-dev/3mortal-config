#!/usr/bin/env bash

sketchybar --add event aerospace_fullscreen_toggle

sketchybar --add item fullscreen_watcher left \
    --set fullscreen_watcher \
        drawing=off \
        script="$PLUGIN_DIR/fullscreen_watcher.sh" \
    --subscribe fullscreen_watcher aerospace_fullscreen_toggle
