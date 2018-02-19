#!/bin/bash

curl -s -O https://raw.githubusercontent.com/robperc/FinderSidebarEditor/master/FinderSidebarEditor.py

python -c "
from FinderSidebarEditor import FinderSidebar
sidebar = FinderSidebar()
sidebar.remove('All My Files')
sidebar.remove('Documents')
sidebar.remove('Recents.cannedsearch')
sidebar.add('$HOME/Applications')
sidebar.add('/Applications')
sidebar.add('$HOME')
"

rm -rf FinderSidebarEditor.py*
