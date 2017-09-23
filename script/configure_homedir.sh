#!/bin/bash

cd
if [[ ! -d ~/.git ]]; then
    git clone git@github.com:SteveMarshall/homedir.git
    chflags hidden ~/homedir/*
    mv ~/homedir/* ~/homedir/.[^.]* ~
    rm -df ~/homedir
else
    git pull
fi
