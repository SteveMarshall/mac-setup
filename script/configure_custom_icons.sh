#!/bin/bash

# TODO: Make this work remotely?

github_root="${GITHUB_ROOT:-https://raw.githubusercontent.com/SteveMarshall/mac-setup/main}"
script_location=$( [ -z "${BASH_SOURCE[0]}" ] && echo "remote" || echo "local" )

function get_icon_file {
  local script_location="$1"
  local app="$2"

  echo "custom-icons/${app}.icns"
}

function install_icon {
  local script_location="$1"
  local app="$2"
  local appdir="/Applications/${app}.app"
  if [ -d "${HOME}/${appdir}" ]; then
    appdir="${HOME}/${appdir}"
  fi

  if [ ! -d "${appdir}" ]; then
    >&2 echo "Couldn't find ${app} installed!"
  fi
  local icon_file=$( get_icon_file "$script_location" "$app" )

  fileicon set "${appdir}" "${icon_file}"
}

for icon_path in custom-icons/*; do
  app=$(basename "${icon_path%.*}")
  install_icon "$script_location" "$app"
done
