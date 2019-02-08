set fish_plugins theme git rbenv rails brew bundler gem osx pbcopy better-alias gi peco z tmux

# history search with peco
function fish_user_key_bindings
  bind \cr peco_select_history
  bind \cf peco_change_directory
end

# PATH
set -U fish_user_paths $fish_user_paths $HOME/bin
set -U fish_user_paths $fish_user_paths $HOME/.anyenv/bin
# anyenv
if test -x anyenv
   set -U fish_user_paths $fish_user_paths $HOME/.anyenv/bin
   eval (anyenv init - | source)
end

# golang
set -Ux GOPATH $HOME
set -U fish_user_paths $fish_user_paths $GOPATH/bin
set -g fish_user_paths "/usr/local/opt/mysql-client/bin" $fish_user_paths

set -x PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/platform/google_appengine $PATH
