#!/bin/bash

type -t dockutil >/dev/null \
  || brew install --cask hpedrorodrigues/tools/dockutil

github_root="${GITHUB_ROOT:-https://raw.githubusercontent.com/SteveMarshall/mac-setup/main}"
script_location=$( [ -z "${BASH_SOURCE[0]}" ] && echo "remote" || echo "local" )

if [ -f "machine-type/${MACHINE_TYPE}/Dockfile" ]; then
  dockfiles=(
    "machine-type/${MACHINE_TYPE}/Dockfile"
  )
fi

function get_dockfile {
  local location="$1"
  local dockfile="$2"

  if [[ "remote" == "${location}" ]]; then
    curl_temp_file=$( mktemp -t mac-setup.dockfile.XXXXX )
    curl -sSL "${github_root}/${dockfile}" > "${curl_temp_file}"
    echo "${curl_temp_file}"
    return
  fi
  echo "${dockfile}"
}

function process_dockfile_line {
  local command="$1"
  local app="$2"
  local alias="$3"

  case "$command" in
    add)
      case "$app" in
        /*) ;;
        *)  app="/Applications/$app.app"
            ;;
      esac

      if [ -n "$alias" ]; then
        dockutil \
          --add "$app" \
          --label "$alias" \
          --no-restart \
          || true
      else
        dockutil \
          --add "$app" \
          --no-restart \
          || true
      fi
      ;;

    remove)
      echo "Removing $app"
      dockutil --remove "$app" --no-restart \
        >/dev/null  # not being in the dock is not an error
      ;;

    ''|\#*)
      # comment or blank line, ignore
      ;;

    *)  echo "Unknown action $command: $@"
      ;;
  esac
}


for dockfile in "${dockfiles[@]}"; do
  dockfile=$( get_dockfile "$script_location" "$dockfile" )
  while IFS= read -r line; do
    eval process_dockfile_line $line
  done < "${dockfile}"
done

killall Dock
