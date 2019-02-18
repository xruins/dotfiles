# set shell for WSL
set -x SHELL (command -v fish)

# fisherman
if not functions -q fisher
    set -q XDG_CONFIG_HOME
    or set XDG_CONFIG_HOME ~/.config
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
if type -q anyenv
   eval (anyenv init - | source)
end

# golang
set -U GOPATH $HOME
set -U fish_user_paths $fish_user_paths $GOPATH/bin

set -U PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/platform/google_appengine $PATH

# Google Cloud SDK
if type -q gcloud
    if test -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
        set -U GCLOUD_ROOT_PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
    else if test -d ~/google-cloud-sdk
        set -U GCLOUD_ROOT_PATH ~/google-cloud-sdk
    else if test -d /usr/share/google-cloud-sdk/
        set -U GCLOUD_ROOT_PATH /usr/share/google-cloud-sdk
    end
    if test -n $GCLOUD_ROOT_PATH
        for f in $GCLOUD_ROOT_PATH/*.fish.inc
            source $f
        end
    end
end