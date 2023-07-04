#!/bin/bash

trigger=/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress

devdir=$( xcode-select -print-path 2>/dev/null || true )
[ -z "${devdir}" ] \
    || ! [ -f "${devdir}/usr/bin/git" ] && {

    echo 'downloading Xcode Command Line Tools'

    # forces softwareupdate to list the cli tools
    sudo touch "${trigger}"
    package=$(
        softwareupdate -l \
            | egrep '\* Command Line (Dev|Tools)' \
            | sed -e 's/^[ *]*//'
    )
    sudo softwareupdate -i "${package}"
    sudo rm -f "${trigger}"

    if ! [ -f "${devdir}/usr/bin/git" ]; then
        # user install of tools
        xcode-select --install
    fi
}
