#!/bin/bash

osascript -e "
tell application \"System Events\"
  delete login items
  make login item at end with properties { \
    path: \"/Applications/iTunes.app\", \
    hidden: true \
  }
  make login item at end with properties { \
    path: \"$HOME/Applications/Transmission.app\", \
    hidden: true \
  }
  \"Updated login items\"
end tell
"
