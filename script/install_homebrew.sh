#!/bin/bash

required_dirs=(Homebrew Cellar Frameworks bin etc include lib opt sbin share var)

if ! type -t brew >/dev/null; then
    echo 'Install homebrew'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    brew doctor
else
    brew update
    brew upgrade
fi
