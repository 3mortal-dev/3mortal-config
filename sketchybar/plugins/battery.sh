#!/bin/sh

if [ -f "$CONFIG_DIR/colors.sh" ]; then
    . "$CONFIG_DIR/colors.sh"
fi
GOOD_COLOR="${GOOD_COLOR:-0xff6fd68f}"
WARN_COLOR="${WARN_COLOR:-0xffe0b34d}"
BAD_COLOR="${BAD_COLOR:-0xffe0666f}"
ACCENT_COLOR="${ACCENT_COLOR:-0xff8f97b3}"

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  9[0-9]|100) ICON="􀛨"
  ;;
  [6-8][0-9]) ICON="􀺸"
  ;;
  [3-5][0-9]) ICON="􀺶"
  ;;
  [1-2][0-9]) ICON="􀛩"
  ;;
  *) ICON="􀛪"
esac

# Color-code by charge level: plenty=green, getting low=amber, critical=red
case ${PERCENTAGE} in
  [3-9][0-9]|100) COLOR="$GOOD_COLOR" ;;
  2[0-9]) COLOR="$WARN_COLOR" ;;
  *) COLOR="$BAD_COLOR" ;;
esac

if [ "$CHARGING" != "" ]; then
  ICON="􀢋"
  COLOR="$ACCENT_COLOR"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set $NAME icon="$ICON" icon.color="$COLOR" label="${PERCENTAGE}%"
