#!/usr/bin/env bash

# Clean out old items
sketchybar --remove '/space\..*/' space_controller 2>/dev/null

# Matches the workspaces actually bound in aerospace.toml
# (H, J, K, L are intentionally excluded - they're used for
# focus left/down/up/right, not workspace switching)
SPACE_SIDS=(
    1 2 3 4 5 6 7 8 9
    A B C D E F G I M N O P Q R S T U V W X Y Z
)

# 1. Pre-register all workspaces
for sid in "${SPACE_SIDS[@]}"; do
    sketchybar --add item "space.$sid" left \
        --set "space.$sid" \
            icon="$sid" \
            icon.font="SF Pro:Bold:15.0" \
            icon.padding_left=8 \
            icon.padding_right=5 \
            icon.padding_bottom=5 \
            label.font="sketchybar-app-font:Regular:16.0" \
            label.y_offset=0\
            label.padding_left=2 \
            label.padding_right=8 \
            background.height=22 \
            background.corner_radius=6 \
            background.drawing=off \
            drawing=off \
            click_script="/opt/homebrew/bin/aerospace workspace $sid"
done

# 2. Register the custom event before anything can subscribe to or trigger
# it - without this, `sketchybar --trigger aerospace_workspace_change`
# silently does nothing, no matter where it's called from.
sketchybar --add event aerospace_workspace_change

# 3. Add controller item that updates all workspaces in one batch
sketchybar --add item space_controller left \
    --set space_controller \
        drawing=off \
        script="$PLUGIN_DIR/space_controller.sh" \
    --subscribe space_controller aerospace_workspace_change front_app_switched display_change

# 4. Trigger initial draw
"$PLUGIN_DIR/space_controller.sh"