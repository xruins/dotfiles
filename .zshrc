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

# 大文字と小文字を区別しない
export CASE_SENSITIVE="false"

# ----------------------------------------
#  zgen
# ----------------------------------------
source $HOME/dotfiles/.zgen/zgen.zsh

if ! zgen saved; then
	echo "Creating a zgen save"

	zgen prezto editor key-bindings 'emacs'
	zgen prezto prompt theme 'paradox'
	zgen prezto '*:*' case-sensitive 'no'
	zgen prezto '*:*' color 'yes'

	zgen prezto
	zgen prezto git
	zgen prezto command-not-found
	zgen prezto tmux
	zgen prezto fasd
	zgen prezto history-substring-search
	zgen prezto syntax-highlighting

	#zgen load djui/alias-tips
	zgen load caarlos0/zsh-git-sync
	zgen load TBSliver/zsh-plugin-colored-man
	zgen load mafredri/zsh-async

	zgen load zsh-users/zsh-syntax-highlighting
	zgen load tarruda/zsh-autosuggestions

	zgen save
fi

# ----------------------------------------
# zsh built-in function
# ----------------------------------------

# 補完機能の強化
autoload -U compinit
compinit

setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示
setopt print_eight_bit       # 日本語ファイル名等8ビットを通す
setopt extended_glob         # 拡張グロブで補完(~とか^とか。例えばless *.txt~memo.txt ならmemo.txt 以外の *.txt にマッチ)
setopt globdots              # 明確なドットの指定なしで.から始まるファイルをマッチ
setopt list_packed           # リストを詰めて表示
setopt auto_cd               # ディレクトリ名だけでcd
setopt auto_pushd            # pushdの自動化(cd -[tab]用)
setopt correct               # コマンド名をtypoした時に修正するか尋ねる
# setopt prompt のスタイル変更
SPROMPT="correct: $RED%R$DEFAULT -> $GREEN%r$DEFAULT ? [No/Yes/Abort/Edit]"
setopt list_packed           # 補完リストを詰めて表示する
setopt noautoremoveslash     # ディレクトリ名の末尾の/を除去しない
setopt nolistbeep            # 補完リストを表示した際のbeepを無効化
setopt braceccl              # ブレース展開の有効化
setopt complete_aliases      # aliasも補完対象とする
setopt share_history         # 端末間で履歴を共有
# 履歴に残すコマンドの重複を排除
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups

unsetopt bg_nice             # バックグラウンドジョブを通常の優先度で実行

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

#----------------------------------------
# smart
#----------------------------------------

autoload -Uz smart-insert-last-word
# [a-zA-Z], /, \ のうち少なくとも1文字を含む長さ2以上の単語
zstyle :insert-last-word match '*([[:alpha:]/\\]?|?[[:alpha:]/\\])*'
zle -N insert-last-word smart-insert-last-word
bindkey '^]' insert-last-word

# ----------------------------------------
#  include
# ----------------------------------------

[ -f ~/dotfiles/.zsh/.zshrc.alias ] && source ~/dotfiles/.zsh/.zshrc.alias
[ -f ~/dotfiles/.zsh/.zshrc.export ] && source ~/dotfiles/.zsh/.zshrc.export
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

source ~/dotfiles/.zsh/z.sh

# -------------------------------------
# named directory
# -------------------------------------

setopt CDABLE_VARS
hash -d desktop=$HOME/Desktop
hash -d doc=$HOME/Documents
hash -d repos=$HOME/repos

# ----------------------------------------
#  rbenv
# ----------------------------------------

if [ -d $HOME/.rbenv ]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
    eval "$(rbenv init -)"
fi

# ----------------------------------------
#  Homebrew
# ----------------------------------------

# brewコマンドが実行可能な場合のみ適用する
if [ -x brew ]; then
    # brew file 用のwrapper
    if [ -f $(brew --prefix)/etc/brew-wrap ];then
        source $(brew --prefix)/etc/brew-wrap
    fi
fi

# ----------------------------------------
#  golang
# ----------------------------------------

[ -x go ] && export GOPATH=$HOME/.go

# ----------------------------------------
#  zsh prompt theme init
# ----------------------------------------

autoload -Uz promptinit
promptinit
prompt paradox
