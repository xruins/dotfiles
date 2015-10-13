# ----------------------------------------
# Foundation
# ----------------------------------------

autoload colors
colors

export LANG='ja_JP.UTF-8'
export PAGER='less'
export EDITOR='emacs'

# ヒストリ
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data


# 大文字と小文字を区別しない
export CASE_SENSITIVE="false"


# ----------------------------------------
# zsh built-in function
# ----------------------------------------

# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
setopt correct

# compacked complete list display
setopt list_packed

# no remove postfix slash of command line
setopt noautoremoveslash

# no beep sound when complete list displayed
setopt nolistbeep

# すべてのバックグラウンドジョブを低優先度で実行を解除
unsetopt bg_nice

# ブレース展開の有効化
setopt braceccl

# vcs_info 設定

RPROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
autoload -Uz colors


# ----------------------------------------
# Keybind
# ----------------------------------------

# emacs like ( C-aで文頭、C-eで文末など )
bindkey -e

# ^P, ^N での検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# ----------------------------------------
# Less
# ----------------------------------------

export LESS='-R'
SRC_HIGHLIGHT_PATH="/usr/share/source-highlight/src-hilite-lesspipe.sh"
[ -x ${SRC_HIGHLIGHT_PATH} ] && export LESSOPEN="| ${SRC_HIGHLIGHT_PATH} %s"


# ----------------------------------------
# Completion
# ----------------------------------------

fpath=(~/.zsh/completion $fpath)

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
autoload -U compinit
compinit -u

# TAB補完の機能をaliasにも追加
_Z_CMD=j
compctl -U -K _z_zsh_tab_completion $_Z_CMD

# ----------------------------------------
# Appearance
# ----------------------------------------

# ls の色付け指定
unset LSCOLORS
case "${TERM}" in
xterm)
  export TERM=xterm-color
  ;;
kterm)
  export TERM=kterm-color
  # set BackSpace control character
  stty erase
  ;;
cons25)
  unset LANG
  export LSCOLORS=ExFxCxdxBxegedabagacad
  export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
  zstyle ':completion:*' list-colors \
    'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
  ;;
esac

# Terminal のタイトルにカレントディレクトリを追加
case "$TERM" in
    xterm*|kterm*|rxvt*)
    PROMPT=$(print "%B%{\e[34m%}%m:%(5~,%-2~/.../%2~,%~)%{\e[33m%}%# %b")
    PROMPT=$(print "%{\e]2;%n@%m: %~\7%}$PROMPT") # title bar
    ;;
    *)
    PROMPT='%m:%c%# '
    ;;
esac

# ----------------------------------------
# Functions
# ----------------------------------------

# 解凍 http://d.hatena.ne.jp/jeneshicc/20110215/1297778049
function extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.lzma)      lzma -dv $1    ;;
          *.xz)        xz -dv $1      ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz,lzma,tbz2,rar}=extract

function precmd () {
    _z --add "$(pwd -P)"
}

# own - arg に指定されたファイルの所有者、所有グループを実行中のユーザにする
# usage : own [path]
function own () {
    if [ $ -ne 1 ] ; then
        echo "usage : own [path]"
    fi
    if [ -d $1 -o -f $1 ] ; then
        sudo chgrp $(id -un) $1
        sudo chown $(id -un) $1
    else
        echo "File \"$1\" is not found." >> /dev/null
    fi
}


# ----------------------------------------
#  include
# ----------------------------------------

[ -f ~/dotfiles/.zsh/.zshrc.alias ] && source ~/dotfiles/.zsh/.zshrc.alias
[ -f ~/dotfiles/.zsh/.zshrc.export ] && source ~/dotfiles/.zsh/.zshrc.export
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

source ~/dotfiles/.zsh/z.sh

# ----------------------------------------
#  Java
# ----------------------------------------

# Set JAVA_HOME when works on Mac
if [ "$(uname)" = 'Darwin' ]; then
    export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home`
fi

# ----------------------------------------
#  rbenv
# ----------------------------------------

# .rbenv がホームディレクトリ直下にある場合
if [ -d $HOME/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"

    init_rbenv-binstubs()
fi

# rbenv binstubs setting
function init_rbenv-binstubs () {
    if [ -d $HOME/.rbenv/plugins/rbenv-binstubs ]; then
	export PATH=./vendor/bin:$PATH
	alias be='bundle exec'
    fi
}


# ----------------------------------------
#  Homebrew
# ----------------------------------------

# brewコマンドが実行可能な場合のみ適用する
if [ -x brew ]; then
    # brewupdall - brewで全部アップデート[グレード]する
    function brewupdall() {
        brew update
        if [ $? -ne 0 ]; then
            echo "Failed to brew update."
            return 1
        fi
        brew upgrade --all
        brew file cask_upgrade -C
        brew cleanup
    }
    
    # brew file 用のwrapper
    if [ -f $(brew --prefix)/etc/brew-wrap ];then
        source $(brew --prefix)/etc/brew-wrap
    fi
fi

# ----------------------------------------
# npm
# ----------------------------------------

if [ -x npm ]; then
    export PATH=/usr/local/share/npm/bin:$PATH
    export NODE_PATH=/usr/local/lib/node_modules
fi

# ----------------------------------------
#  oh-my-zsh
# ----------------------------------------

# oh-my-zsh の有効化
ZSH="$HOME/dotfiles/oh-my-zsh"

# テーマ設定
ZSH_THEME="agnoster"

# 自動アップデートの無効化
export DISABLE_AUTO_UPDATE="true"

# プラグイン設定
plugins="git ruby gem rails"

source $ZSH/oh-my-zsh.sh
