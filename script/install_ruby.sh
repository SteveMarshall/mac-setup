#!/bin/bash

ruby_version=`cat ~/.ruby-version`
ruby-install --no-reinstall $ruby_version
for ruby in ~/.rubies/$ruby_version*; do
  $ruby/bin/gem install bundler
done
