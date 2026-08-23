#!/usr/bin/env bash

# Small chevron divider between item groups (e.g. between the spaces
# group and front_app). Purely decorative - no click/script behavior.
sketchybar --add item separator.chevron left \
    --set separator.chevron \
        icon="􀆊" \
        icon.font="SF Pro:Bold:16.0" \
        icon.color=$ACCENT_COLOR \
        icon.padding_left=6 \
        icon.padding_right=6 \
        label.drawing=off \
        background.drawing=off \
        padding_left=2 \
        padding_right=2
