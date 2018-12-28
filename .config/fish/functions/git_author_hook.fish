function change_git_author_on_pwd_changed --description 'Switch git author base on PWD' --on-variable PWD
    if not (string match -i "*dena*" $PWD) -eq 0 # non-DeNA projects
        set GIT_COMMITER_NAME='Ruins'
        set EMAIL='ruinscorocoro+github@gmail.com'
    else # DeNA projects
        set GIT_COMMITER_NAME='Hikaru Watanabe'
        set EMAIL='hikaru.watanabe@dena.com'
    end
    set GIT_AUTHOR_NAME=$GIT_COMMITER_NAME
end
