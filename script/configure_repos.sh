#!/bin/bash

function clone_repo {
  local repo="$1"
  local destination="${2/#\~/${HOME}}"

  if [ ! -d "${destination}" ]; then
    echo "Cloning ${repo} to ${destination}"

    mkdir -p "${destination}"
    git clone git@github.com:$repo.git "${2}"

  else
    echo "Updating ${repo} in ${2}"

    pushd "${destination}" > /dev/null

    git pull --rebase &> /dev/null || echo "Couldn't pull latest changes to $repo"
    popd > /dev/null
  fi

  if [ -f "${destination}/script/bootstrap" ]; then
    echo "Initialising ${repo} in ${destination}"
    pushd "${destination}" > /dev/null
    ./script/bootstrap
    popd > /dev/null
  fi
}

clone_repo "SteveMarshall/mac-setup" "~/Developer/Personal/mac-setup"
clone_repo "SteveMarshall/macos_defaults" "~/etc/macos/defaults"
clone_repo "SteveMarshall/TextMate-application-support" "~/Library/Application Support/TextMate"
