#!/bin/bash

if ! softwareupdate -l 2>&1 | grep 'No new software'; then
    sudo softwareupdate --install --all
fi
