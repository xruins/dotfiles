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

function execute_pp () {
    local cmd="$1"
    local out=$(${cmd} 2>&1)
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ successfuly executed ${cmd}${RESET}"
        return 1
    else
        echo -e "${RED}✗ failed to execute from ${cmd}\nOUTPUT: ${out}"
        return 0
    fi
}

function notice () {
    local text="$1"
    echo -e "📝 ${text}"
}

function make_symlink () {
    local src="$1"
    local dst="$2"

    local cmd="ln -s $1 $2"
    local out=$(${cmd} 2>&1)
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ successfully created symlink from ${src} to ${dst}${RESET}"
        return 0
    else
        echo -e "${RED}✗ failed to created symlink from ${src} to ${dst}${RESET}\nCOMMAND: ${cmd}\nOUTPUT: ${out}"
        return 1
    fi
}

# make symbolic links for top-level files/directory
for file in $(ls -A .)
do
    if !(contains "${file}" ${IGNORE_LIST[@]}); then
        make_symlink $(realpath $file) $HOME/$file
    fi
done

# make symbolic links for directories under ".config/"
for file in $(ls -A .config)
do
        make_symlink $(realpath .config/$file) $HOME/.config/$file
done

fish=$(command -v fish)
# chsh for fish and install oh-my-fish
if [ $? -eq 0 ]; then
    notice "attempts to change default shell since found fish executable. your password may be required."
    chsh -s ${fish}
    notice "attempts to install oh-my-fish."
    execute_pp "curl -L http://get.oh-my.fish | fish"
else
    notice "skip to change default shell since lacks fish executable."
fi
