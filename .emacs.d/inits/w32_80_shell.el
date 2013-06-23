;; Windows ( Cygwin ) 上におけるシェルの設定

(setq explicit-shell-file-name "c:\\Apps\\cygwin\\bin\\zsh.exe")
(modify-coding-system-alist 'process "shell" '(undecided-dos . utf-8-unix))

;; ^M をとる
(add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;; shell-modeでの補完 (for drive letter)
(setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@'`.,;()-")
