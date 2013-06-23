
(require 'linum)
(global-linum-mode t)
(setq linum-format
      ;; 非window-mode 時は末尾にスペースを開けるようにする
      (if window-system "%4d" "%4d ")
)
