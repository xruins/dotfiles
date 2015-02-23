#!/bin/sh

DOT_FILES=( .zshrc .gitconfig .gitignore .tmux.conf .emacs.d .vimperatorrc .oh-my-zsh .subversion .zsh )

DISCARD_FILES=( .emacs .emacs.el .emacs.elc )

# 不要なファイルをバックアップして捨てる
for discard in ${DISCARD_FILES[@]}
do
   if [ -e $HOME/$discard ]; then
       mv -f $HOME/$discard $HOME/${discard}.old.`date +%y%m%d`
   fi
done

# シンボリックリンクをはる
for file in ${DOT_FILES[@]}
do
    rm -rf $HOME/$file
    ln -s $HOME/dotfiles/$file $HOME/$file
done

touch ~/.z

# Cask のインストール
if [ !-d $HOME/.cask ]; then
    echo 'install cask? (Y/n)'
    read ANSWER

    if [ $ANSWER -eq 'Y' ]; then
        install_cask()
    fi
fi


function install_cask() {
    curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
}
