function fzf_select_history
    history | fzf --query "$argv" | read fzf_select_history_result

    if [ $foo ]
        commandline $fzf_select_history_result
    else
        commandline ''
    end
end
