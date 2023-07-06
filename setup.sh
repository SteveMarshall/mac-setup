#!/bin/bash
set -e

curl_temp_file=$( mktemp '/tmp/mac-setup.curl.XXXXX' )
github_root="${GITHUB_ROOT:-https://raw.githubusercontent.com/SteveMarshall/mac-setup/main}"
script_location=$( [ -z "${BASH_SOURCE[0]}" ] && echo "remote" || echo "local" )

scripts=(
  "script/install_xcode.sh"
  "script/install_homebrew.sh"
  "script/install_brew_packages.sh"
  "script/software_update.sh"
  "script/configure_homedir.sh"
  "script/configure_repos.sh"
  "script/configure_backblaze.sh"
)

function get_script {
  local location="$1"
  local script="$2"

  if [[ "remote" == "${location}" ]]; then
    curl -sSL "${github_root}/${script}" > "${curl_temp_file}"
    echo "${curl_temp_file}"
    return
  fi
  echo "${script}"
}

function execute_script {
  local script="$1"
  source "$( get_script "${script_location}" "${script}" )"
}

for script in "${scripts[@]}"; do
  echo "Executing ${script}"
  execute_script "${script}"
done
