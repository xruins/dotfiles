function fzf_select_history
    history | fzf --query "$argv" | read fzf_select_history_result

    if test $status -eq 0 ]
        commandline $fzf_select_history_result
    else
        commandline ''
    end
end
