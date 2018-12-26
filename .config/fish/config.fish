set fish_plugins theme git rbenv rails brew bundler gem osx pbcopy better-alias gi peco z tmux

# history search with peco
function fish_user_key_bindings
  bind \cr peco_select_history
  bind \cf peco_change_directory
end

# PATH
set -U fish_user_paths $fish_user_paths $HOME/bin

# anyenv
set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

# golang
set -Ux GOPATH $HOME
set -U fish_user_paths $fish_user_paths $GOPATH/bin
