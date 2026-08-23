#!/bin/bash

# Clean out old items
sketchybar --remove '/space\..*/' space_controller 2>/dev/null

SPACE_SIDS=(
    1 2 3 4 5 6 7 8 9
    A B C D E F G I M N O P Q R S T U V W X Y Z
)

# 1. Pre-register all workspaces (hidden by default)
for sid in "${SPACE_SIDS[@]}"; do
    sketchybar --add item "space.$sid" left \
        --set "space.$sid" \
            icon="$sid" \
            icon.font="SF Pro:Bold:14.0" \
            icon.padding_left=8 \
            icon.padding_right=4 \
            label.font="sketchybar-app-font:Regular:14.0" \
            label.padding_right=8 \
            background.height=24 \
            background.corner_radius=6 \
            background.drawing=off \
            drawing=off \
            click_script="aerospace workspace $sid"
done

# 2. Register the single observer that updates all workspaces at once
sketchybar --add item space_controller left \
    --set space_controller \
        drawing=off \
        script="$PLUGIN_DIR/space_controller.sh" \
    --subscribe space_controller aerospace_workspace_change front_app_switched space_windows_change display_change

# 3. Initial draw
"$PLUGIN_DIR/space_controller.sh"