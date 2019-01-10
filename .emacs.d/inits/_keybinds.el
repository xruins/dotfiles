;;;; modifier keys
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))


(global-set-key (kbd "C-h") 'left-char)
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-k") 'previous-line)
(global-set-key (kbd "C-l") 'right-char)

(define-key global-map (kbd "C-z") 'other-window)
(define-key global-map (kbd "C-t") 'other-window)
