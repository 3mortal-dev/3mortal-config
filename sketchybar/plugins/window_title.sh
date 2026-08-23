#!/bin/bash

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:$PATH"

TITLE=$(aerospace list-windows --focused --format "%{window-title}" 2>/dev/null)

if [ -z "$TITLE" ]; then
    TITLE="Desktop"
fi

sketchybar --set $NAME label="$TITLE"
