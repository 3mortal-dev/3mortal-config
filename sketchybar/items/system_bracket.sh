#!/bin/bash

# Groups cpu, volume, and battery into a single shared pill (one background
# spanning all three) instead of three separate boxes - reads as one
# "system status" cluster instead of a disconnected row of icons.
# NOTE: must be sourced after items/cpu.sh, items/volume.sh, and
# items/battery.sh, since the bracket references items that must already exist.
sketchybar --add bracket system_stats cpu volume battery \
    --set system_stats background.color=$ITEM_BG_COLOR \
                        background.corner_radius=7 \
                        background.height=24 \
                        background.drawing=on
