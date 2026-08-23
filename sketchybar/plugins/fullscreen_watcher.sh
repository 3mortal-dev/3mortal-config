#!/bin/bash

STATE_FILE="/tmp/sb_fullscreen_state"

if [ -f "$STATE_FILE" ]; then
    # --- Exit Fullscreen: Restore Standard Floating Bar ---
    rm -f "$STATE_FILE"
    
    sketchybar --bar height=34 \
                     margin=8 \
                     y_offset=6 \
                     corner_radius=12 \
                     padding_left=8 \
                     padding_right=8 \
               --set '/.*/' background.height=24
else
    # --- Enter Fullscreen: Shrink into a Stable Narrow Strip ---
    touch "$STATE_FILE"
    
    sketchybar --bar height=22 \
                     margin=0 \
                     y_offset=0 \
                     corner_radius=0 \
                     padding_left=4 \
                     padding_right=4 \
               --set '/.*/' background.height=16
fi