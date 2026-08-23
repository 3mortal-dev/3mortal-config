#!/bin/zsh

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:$PATH"

# TEMP DEBUG - remove after diagnosing
echo "$(date +%T) SENDER=$SENDER FOCUSED_WORKSPACE=$FOCUSED_WORKSPACE FOCUSED_WINDOW_ID=$FOCUSED_WINDOW_ID" >> /tmp/sb_debug.log


# Load colors or fallback
if [ -f "$CONFIG_DIR/colors.sh" ]; then
    source "$CONFIG_DIR/colors.sh"
fi

BAR_COLOR="${BAR_COLOR:-0xff101014}"
ACCENT_COLOR="${ACCENT_COLOR:-0xff8f97b3}"
WHITE="${WHITE:-0xffd8d8e0}"
DIM_COLOR="${DIM_COLOR:-0xff5c5c66}"

# Source icon map (official sketchybar-app-font script: defines __icon_map,
# which sets the result in $icon_result rather than echoing it)
# NOTE: use $CONFIG_DIR here, not $PLUGIN_DIR - PLUGIN_DIR only exists inside
# sketchybarrc's shell; SketchyBar auto-injects CONFIG_DIR into every script
# it spawns, so it's the one guaranteed to be set here.
if [ -f "$CONFIG_DIR/plugins/icon_map.sh" ]; then
    source "$CONFIG_DIR/plugins/icon_map.sh"
    icon_map() {
        __icon_map "$1"
        echo "$icon_result"
    }
else
    icon_map() { echo "•"; }
fi

# Max app icons to show per workspace before collapsing to "+N" - keeps
# heavily populated spaces from turning into a wall of glyphs.
MAX_ICONS=3

# 1. Get currently focused workspace.
# Prefer values AeroSpace passes directly via the trigger - these are
# authoritative and race-free, unlike polling `aerospace list-workspaces
# --focused` after the fact:
#   - exec-on-workspace-change gives us FOCUSED_WORKSPACE directly.
#   - on-focus-changed only gives us the newly-focused window's ID
#     (FOCUSED_WINDOW_ID), since focus targets a window, not a workspace -
#     so we look up that specific window's workspace, which is static data
#     and can't race the way "what's focused right now" can.
# Only fall back to polling for events that carry neither (e.g. display_change).
if [ -n "$FOCUSED_WORKSPACE" ]; then
    FOCUSED=$(echo "$FOCUSED_WORKSPACE" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')
elif [ -n "$FOCUSED_WINDOW_ID" ]; then
    FOCUSED=$(aerospace list-windows --window-id "$FOCUSED_WINDOW_ID" --format "%{workspace}" 2>/dev/null | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')
fi
if [ -z "$FOCUSED" ]; then
    FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')
fi

# TEMP DEBUG - remove after diagnosing
echo "$(date +%T) resolved FOCUSED=$FOCUSED" >> /tmp/sb_debug.log

# 2. Query ALL open windows
WINDOW_DATA=$(aerospace list-windows --all --format "%{workspace}|%{app-name}" 2>/dev/null)

typeset -A WS_ICONS
typeset -A WS_COUNT
typeset -A WS_HAS_WINDOWS

if [ -n "$WINDOW_DATA" ]; then
    while IFS='|' read -r ws app; do
        ws=$(echo "$ws" | tr -d '[:space:]' | tr '[:lower:]' '[:upper:]')
        [ -z "$ws" ] && continue
        WS_HAS_WINDOWS[$ws]=1
        count=${WS_COUNT[$ws]:-0}
        count=$((count + 1))
        WS_COUNT[$ws]=$count
        if [ "$count" -le "$MAX_ICONS" ]; then
            icon=$(icon_map "$app")
            WS_ICONS[$ws]+="$icon "
        fi
    done <<< "$WINDOW_DATA"
fi

# Matches the SPACE_SIDS list in spaces.sh
ALL_SPACES=(
    1 2 3 4 5 6 7 8 9
    A B C D E F G I M N O P Q R S T U V W X Y Z
)

CMD=()

# 3. Build the batch configuration
for sid in "${ALL_SPACES[@]}"; do
    icons="${WS_ICONS[$sid]}"
    count="${WS_COUNT[$sid]:-0}"
    has_win="${WS_HAS_WINDOWS[$sid]}"

    # Trim trailing space, then append overflow marker if needed
    icons="${icons% }"
    if [ "$count" -gt "$MAX_ICONS" ]; then
        overflow=$((count - MAX_ICONS))
        icons="$icons +$overflow"
    fi

    # Single-icon labels sit better unshifted; multi-icon labels need the
    # -2 nudge to line up with the workspace letter's vertical center.
    if [ "$count" -eq 1 ]; then
        label_yoff=0
    else
        label_yoff=-2
    fi

    if [ "$sid" = "$FOCUSED" ]; then
        # FOCUSED WORKSPACE -> Muted accent pill, always shown even if empty
        CMD+=(
            --set "space.$sid"
                drawing=on
                label="$icons"
                label.y_offset="$label_yoff"
                icon.color="$WHITE"
                label.color="0xff1ee8a1"
                background.color="0xff0b004f"
                background.drawing=on
        )
    elif [ -n "$has_win" ]; then
        # INACTIVE WORKSPACE WITH WINDOWS -> faint pill so it stays legible
        # over bright/busy wallpapers, still clearly dimmer than the focused one
        CMD+=(
            --set "space.$sid"
                drawing=on
                label="$icons"
                label.y_offset="$label_yoff"
                icon.color="0xffadadad"
                label.color="0xfffa89d1"
                background.color="$ITEM_BG_COLOR"
                background.drawing=on
        )
    else
        # EMPTY, UNFOCUSED WORKSPACE -> Hide
        CMD+=(
            --set "space.$sid"
                drawing=off
        )
    fi
done

# 4. Atomically apply to SketchyBar
if [ ${#CMD[@]} -gt 0 ]; then
    sketchybar "${CMD[@]}"
fi