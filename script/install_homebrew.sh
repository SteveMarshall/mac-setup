#!/bin/bash

required_dirs=(Homebrew Cellar Frameworks bin etc include lib opt sbin share var)

if ! type -t brew >/dev/null; then
    status 'Install homebrew'
    sudo git clone git@github.com:Homebrew/brew.git "$HOMEBREW_REPOSITORY"
    sudo ln -sf "$HOMEBREW_REPOSITORY/bin/brew" "$HOMEBREW_PREFIX/bin/brew"
    git -C "$(brew --repo homebrew/core)" fetch --unshallow

    silent_pushd $HOMEBREW_PREFIX
    sudo mkdir -p "${required_dirs[@]}"
    sudo chown -R $USER "${required_dirs[@]}"
    silent_popd

    brew doctor
else
    brew update
    brew upgrade
fi
