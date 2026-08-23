#!/bin/bash

if [ "$MODE" = "service" ]; then
    sketchybar --set mode_indicator drawing=on
else
    sketchybar --set mode_indicator drawing=off
fi
