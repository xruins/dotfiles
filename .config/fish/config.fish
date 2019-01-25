set fish_plugins theme git rbenv rails brew bundler gem osx pbcopy better-alias gi peco z tmux

# history search with peco
function fish_user_key_bindings
  bind \cr peco_select_history
  bind \cf peco_change_directory
end

# PATH
set -Ux fish_user_paths $fish_user_paths $HOME/bin

# anyenv
set -Ux fish_user_paths $fish_user_paths $HOME/.anyenv/bin
if [[ -x anyenv ]]; then
   eval (anyenv init - | source)
fi

# golang
set -Ux GOPATH $HOME
