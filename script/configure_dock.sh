#!/bin/bash

type -t dockutil >/dev/null \
  || brew install --cask dockutil

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
  local rel="$3"
  local rel_app="$4"
  local replacing="$5"

  case "$command" in
    add)
      if [ -z "$replacing" ]; then
        replacing="$app"
      fi

      case "$app" in
        /*) ;;
        *)  app="/Applications/$app.app"
            ;;
      esac

      if [ -n "$rel" ]; then
        dockutil \
          --add "$app" \
          --$rel "$rel_app" \
          --replacing $replacing \
          --no-restart \
          || true
      else
        dockutil \
          --add "$app" \
          --replacing $replacing \
          --no-restart \
          || true
      fi
      ;;

    remove)
      dockutil --remove "$app" --no-restart \
        >/dev/null  # not being in the dock is not an error
      ;;

    ''|\#*)
      # comment or blank line, ignore
      ;;

    *)  status "Unknown action $command: $@"
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
