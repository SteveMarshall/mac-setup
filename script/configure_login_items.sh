#!/bin/bash

if [ "dev" == "${MACHINE_TYPE}" ]; then
  login_items=(
    "$HOME/Library/Application Support/Things Sandbox Helper/ThingsMacSandboxHelper.app"
    "$HOME/Applications/Utilities/Moom.app"
    "$HOME/Applications/Utilities/Choosy.app"
  )
elif [ "server" == "${MACHINE_TYPE}" ]; then
  login_items=(
    "/Applications/iTunes.app"
  )
fi

osascript -e "
tell application \"System Events\"
  delete login items
end tell
"
for login_item in "${login_items[@]}"; do
  osascript -e "
    tell application \"System Events\"
      make login item at end with properties { \
        path: \"${login_item}\" \
      }
    end tell
  "
done

echo "Updated login items"
