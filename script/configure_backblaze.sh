#!/bin/bash

if [ ! -d /Library/Backblaze.bzpkg ]; then
  if [ -z ${BACKBLAZE_USER+x} -o -z ${BACKBLAZE_PASSWORD+x}  ]; then
    echo 'Ensure $BACKBLAZE_USER and $BACKBLAZE_PASSWORD are set'
    exit -1
  fi

  BACKBLAZE_INSTALLER=`brew --prefix`/Caskroom/backblaze/latest/Backblaze\ Installer.app
  sudo $BACKBLAZE_INSTALLER/Contents/MacOS/bzinstall_mate  -nogui \
    -signinaccount $BACKBLAZE_USER $BACKBLAZE_PASSWORD
fi
