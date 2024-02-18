function cbn --description 'show git current branch name'
    git rev-parse --abbrev-ref HEAD
end
