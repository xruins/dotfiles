# fisherman
if not functions -q fisher
    set -q XDG_CONFIG_HOME
    or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# history search with peco
function fish_user_key_bindings
    bind \cr fzf_select_history
    bind \cf fzf_change_directory
    bind \co fzf_open_with_emacs
end

# PATH
set -x fish_user_paths $fish_user_paths $HOME/bin

# snap (ubuntu)
if test -d /snap/bin
    set -x fish_user_paths $fish_user_paths /snap/bin
end

# homebrew
if test -d /opt/homebrew/bin
    set -x fish_user_paths $fish_user_paths /opt/homebrew/bin
end

# golang
set -x GOPATH $HOME

# anyenv
if type -q anyenv
    set -x fish_user_paths $fish_user_paths $HOME/.anyenv/bin
    eval (anyenv init - | source)
end

# direnv
if type -q direnv
    eval (direnv hook fish)
end

# Google Cloud SDK
if test -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
    set -x GCLOUD_ROOT_PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
else if test -d ~/google-cloud-sdk
    set -x GCLOUD_ROOT_PATH ~/google-cloud-sdk
else if test -d /usr/share/google-cloud-sdk/
    set -x GCLOUD_ROOT_PATH /usr/share/google-cloud-sdk
end
if test -d $GCLOUD_ROOT_PATH/platform/google_appengine
    set -x fish_user_paths $fish_user_paths $GCLOUD_ROOT_PATH/platform/google_appengine
end


if test -n $GCLOUD_ROOT_PATH
    for f in $GCLOUD_ROOT_PATH/*.bash.inc
        bass source $f
    end
end

alias emacs='env TERM=xterm emacs'
