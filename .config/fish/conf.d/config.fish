set fish_theme agnoster

set fish_plugins theme peco

function fish_user_key_bindings
  bind \cr peco_select_history # Bind for prco history to Ctrl+r
end

function _peco_change_directory
  if [ (count $argv) ]
    peco --layout=bottom-up --query "$argv "|perl -pe 's/([ ()])/\\\\$1/g'|read foo
  else
    peco --layout=bottom-up |perl -pe 's/([ ()])/\\\\$1/g'|read foo
  end
  if [ $foo ]
    builtin cd $foo
  else
    commandline ''
  end
end
function peco_change_directory
  begin
    echo $HOME/Documents
    echo $HOME/Desktop
    echo $HOME/.config
    ls -ad */|perl -pe "s#^#$PWD/#"|egrep -v "^$PWD/\."|head -n 5
    sort -r -t '|' -k 3 ~/.z|sed -e 's/\|.*//'
    ghq list -p
    ls -ad */|perl -pe "s#^#$PWD/#"|grep -v \.git
  end | sed -e 's/\/$//' | awk '!a[$0]++' | _peco_change_directory $argv
end

function fish_user_key_bindings
  bind \g peco_change_directory
end

fisher oh-my-fish/plugin-balias
fisher oh-my-fish/plugin-expand
fisher oh-my-fish/plugin-peco
fisher oh-my-fish/plugin-extract
fisher fzf
fisher z
fisher edc/bass
fisher oshiori/fish-peco_select_ghq_repository
fisher tsu-nera/fish-peco_open_gh_repository

function fish_user_key_bindings
        # ghq を選択
        bind \cl peco_select_ghq_repository
        # gh-open
        bind \cx\cl peco_open_gh_repository
        # コマンド履歴を見る
        bind \cr peco_select_history
        # プロセスをキルする
        bind \cx\ck peco_kill
        # 最近見たディレクトリに移動
        bind \cx\cr peco_recentd

        # fzf
        bind \cx\cf '__fzf_find_file'
        bind \ctr '__fzf_reverse_isearch'
        bind \ex '__fzf_find_and_execute'
        bind \ed '__fzf_cd'
        bind \eD '__fzf_cd_with_hidden'
end