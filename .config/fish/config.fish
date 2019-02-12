# fisherman
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

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
set -U GOPATH $HOME
set -U fish_user_paths $fish_user_paths $GOPATH/bin

set -U PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/platform/google_appengine $PATH
