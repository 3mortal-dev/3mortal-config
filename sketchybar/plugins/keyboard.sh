#!/bin/bash

# Reads the currently active keyboard input source ID from macOS's own
# preference store. There's no SketchyBar event for input-source changes,
# so this item polls once a second (see update_freq=1 in items/keyboard.sh)
# rather than reacting to a trigger.
SOURCE_ID=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID 2>/dev/null)

case "$SOURCE_ID" in
    *"US"* | *"ABC"*)
        LABEL="EN"
        ;;
    *"Arabic"*)
        LABEL="AR"
        ;;
    *"French"*)
        LABEL="FR"
        ;;
    *"German"*)
        LABEL="DE"
        ;;
    *"Spanish"*)
        LABEL="ES"
        ;;
    "")
        LABEL="?"
        ;;
    *)
        # Fallback: last dotted component of the source ID, uppercased,
        # e.g. "com.apple.keylayout.Russian" -> "RUSSIAN"
        LABEL=$(echo "${SOURCE_ID##*.}" | tr '[:lower:]' '[:upper:]')
        ;;
esac

sketchybar --set keyboard label="$LABEL"
