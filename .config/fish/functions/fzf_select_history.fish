function fzf_select_history
    if history | fzf --query "$argv" | read fzf_select_history_result
        commandline $fzf_select_history_result
    else
        commandline ''
    end
end
