#!/bin/bash

IGNORE_LIST=(.git .config .gitmodules)

function contains () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

RED="\033[0;31m"
GREEN="\033[0;32m"
RESET="\033[0m"

function make_symlink () {
    local src="$1"
    local dst="$2"

    local cmd="ln -s $2 $1"
    local out=$(${cmd} 2>&1)
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ successfully created symlink from ${src} to ${dst}${RESET}"
    else
        echo -e "${RED}✗ failed to created symlink from ${src} to ${dst}${RESET}\nCOMMAND: ${cmd}\nOUTPUT: ${out}"
    fi
}

# make symbolic links for top-level files/directory
for file in $(ls -A .)
do
    if !(contains "${file}" ${IGNORE_LIST[@]}); then
        make_symlink $file $HOME/$file
    fi
done

# make symbolic links for directories under ".config/"
for file in $(ls -A .config)
do
        make_symlink $file $HOME/.config/$file
done

touch ~/.z
