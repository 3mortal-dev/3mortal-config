#!/bin/bash

if [ -f "$CONFIG_DIR/colors.sh" ]; then
    . "$CONFIG_DIR/colors.sh"
fi
GOOD_COLOR="${GOOD_COLOR:-0xff6fd68f}"
WARN_COLOR="${WARN_COLOR:-0xffe0b34d}"
BAD_COLOR="${BAD_COLOR:-0xffe0666f}"

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)
CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")
CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

# Color-code by load: light=green, moderate=amber, heavy=red
case "$CPU_PERCENT" in
  [0-3][0-9]|[0-9]) COLOR="$GOOD_COLOR" ;;
  [4-6][0-9]) COLOR="$WARN_COLOR" ;;
  *) COLOR="$BAD_COLOR" ;;
esac

sketchybar --set $NAME label="$CPU_PERCENT%" icon.color="$COLOR"
