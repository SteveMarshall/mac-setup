#!/bin/bash

github_root="${GITHUB_ROOT:-https://raw.githubusercontent.com/SteveMarshall/mac-setup/main}"
script_location=$( [ -z "${BASH_SOURCE[0]}" ] && echo "remote" || echo "local" )

brewfiles=(
  "Brewfile"
)

if [ -f "machine-type/${MACHINE_TYPE}/Brewfile" ]; then
  brewfiles+=(
    "machine-type/${MACHINE_TYPE}/Brewfile"
  )
fi

function get_brewfile {
  local location="$1"
  local brewfile="$2"

  if [[ "remote" == "${location}" ]]; then
    curl_temp_file=$( mktemp -t mac-setup.brewfile.XXXXX )
    curl -sSL "${github_root}/${brewfile}" > "${curl_temp_file}"
    echo "${curl_temp_file}"
    return
  fi
  echo "${brewfile}"
}

cat $(
  for brewfile in "${brewfiles[@]}"; do
    get_brewfile "$script_location" "$brewfile"
  done
) | brew bundle --no-lock --file=-
