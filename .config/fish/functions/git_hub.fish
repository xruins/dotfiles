function git --description 'use hub command instead of git if executable'
    if text -x hub
        command hub $argv
    else
        command $argv
    end
end