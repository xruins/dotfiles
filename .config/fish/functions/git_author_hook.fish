function change_git_author_on_pwd_changed --description 'Switch git author base on PWD' --on-variable PWD
    if not (string match -i "*dena*" $PWD) -eq 0 # non-DeNA projects
        set -U GIT_COMMITER_NAME Ruins
        set -U EMAIL ruinscorocoro+github@gmail.com
        set -U GITHUB_HOST=github.com
    else # DeNA projects
        set -U GIT_COMMITER_NAME 'Hikaru Watanabe'
        set -U EMAIL hikaru.watanabe@dena.com
        set -U GITHUB_HOST=github.dena.jp
    end
    set -U GIT_AUTHOR_NAME $GIT_COMMITER_NAME
end
