#!/bin/bash

ruby_version=`cat ~/.ruby-version`
if [[ ! -d ~/.rubies/$ruby_version ]]; then
    ruby-install $ruby_version
    ~/.rubies/$ruby_version/bin/gem install bundler
fi
