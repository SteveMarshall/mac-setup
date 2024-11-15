#!/bin/bash
set -e

# Ensure we can refer to brew when it's installed
PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

GITHUB_ROOT="${GITHUB_ROOT:-https://raw.githubusercontent.com/SteveMarshall/mac-setup/main}"

# Expects one of dev or server
if [ "dev" != "${MACHINE_TYPE}" -a "server" != "${MACHINE_TYPE}" ]; then
  echo "No value set for \${MACHINE_TYPE}. \
specify \`dev\` or \`server\` if necessary." >&2
fi

script_location=$( [ -z "${BASH_SOURCE[0]}" ] && echo "remote" || echo "local" )

scripts=(
  "script/install_xcode.sh"
  "script/install_homebrew.sh"
  "script/install_brew_packages.sh"
  "script/software_update.sh"
  "script/configure_homedir.sh"
  "script/configure_repos.sh"
  "script/configure_dock.sh"
  "script/configure_login_items.sh"
  "script/configure_backblaze.sh"
  "script/configure_custom_icons.sh"
)

function get_script {
  local location="$1"
  local script="$2"

  if [[ "remote" == "${location}" ]]; then
    curl_temp_file=$( mktemp -t mac-setup.curl.XXXXX )
    curl -sSL "${GITHUB_ROOT}/${script}" > "${curl_temp_file}"
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
