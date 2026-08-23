#!/bin/sh

# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ -f "$CONFIG_DIR/colors.sh" ]; then
    . "$CONFIG_DIR/colors.sh"
fi
ACCENT_COLOR="${ACCENT_COLOR:-0xff8f97b3}"
DIM_COLOR="${DIM_COLOR:-0xff5c5c66}"

if [ "$SENDER" = "volume_change" ]; then
  VOLUME=$INFO

  case $VOLUME in
    [6-9][0-9]|100) ICON="􀊩"
    ;;
    [3-5][0-9]) ICON="􀊥"
    ;;
    [1-9]|[1-2][0-9]) ICON="􀊡"
    ;;
    *) ICON="􀊣"
  esac

  if [ "$VOLUME" = "0" ]; then
    COLOR="$DIM_COLOR"
  else
    COLOR="$ACCENT_COLOR"
  fi

  sketchybar --set $NAME icon="$ICON" icon.color="$COLOR" label="$VOLUME%"
fi
