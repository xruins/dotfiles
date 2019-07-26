function fzf_open_with_emacs
    rg -l ./ | fzf --query "$argv" | read fzf_select_history_result

    if test $status -eq 0
        emacs $fzf_select_history_result
    else
        commandline ''
    end
end
