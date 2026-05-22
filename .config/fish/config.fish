# fisherman
if not functions -q fisher
    set -q XDG_CONFIG_HOME
    or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

function peco-git-checkout
    git branch -a | peco | tr -d ' ' | read branch
    echo $branch
    if [ $branch ]
        if contains $branch remotes/
            set -l b (echo $branch | awk -F'/' '{print $3}')
            git checkout -b $b $branch
        else
            git checkout $branch
        end
    end
    commandline -f repaint
end

# history search with peco
function fish_user_key_bindings
    bind \cr fzf_select_history
    bind \cf fzf_change_directory
    bind \co fzf_open_with_emacs
    bind \cb peco-git-checkout
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

# ~/.local
if test -d $HOME/.local/bin
    set -x fish_user_paths $fish_user_paths $HOME/.local/bin
end

# golang
set -x GOPATH $HOME

# asdf
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

# direnv
if type -q direnv
    eval (direnv hook fish)
end

# Google Cloud SDK
# (path)
if test -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
    set -x GCLOUD_ROOT_PATH /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk
else if test -d ~/google-cloud-sdk
    set -x GCLOUD_ROOT_PATH ~/google-cloud-sdk
else if test -d /usr/share/google-cloud-sdk/
    set -x GCLOUD_ROOT_PATH /usr/share/google-cloud-sdk
end
if test -f $GCLOUD_ROOT_PATH/path.fish.inc
    source $GCLOUD_ROOT_PATH/path.fish.inc
end

# (completion)
if type -q gcloud
    # thx: https://github.com/lgathy/google-cloud-sdk-fish-completion/blob/master/completions/gcloud.fish
    complete -f -c gcloud -a '(gcloud_sdk_argcomplete)'
end
if type -q gsutil
    # thx: https://github.com/lgathy/google-cloud-sdk-fish-completion/blob/master/completions/gsutil.fish
    complete -x -c gsutil -a '(gcloud_sdk_argcomplete)'
end

# rust
if test -d $HOME/.cargo
    set -x fish_user_paths $fish_user_paths $HOME/.cargo/bin
end

# mise
if type -q mise
    mise activate fish | source
end

# load local settings
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end
