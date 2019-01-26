#!/bin/bash

git clone --depth=1 https://github.com/xruins/dotfiles.git ${HOME}/dotfiles
cd ${HOME}/dotfiles && ./setup.sh
