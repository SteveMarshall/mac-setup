#!/bin/bash

brew_owner=`/usr/bin/stat -f %Su "$(command -v brew)"`
if [[ $brew_owner == 'root' ]]; then
    sudo chown -h $USER `command -v brew`
fi

ruby_version=`cat ~/.ruby-version`
if [[ ! -d ~/.rubies/$ruby_version ]]; then
    ruby-install $ruby_version
    ~/.rubies/$ruby_version/bin/gem install bundler
fi
