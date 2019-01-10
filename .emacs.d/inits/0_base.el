;;;;; start Emacs server
(use-package server
  :ensure t
  :config
  (unless (server-running-p)
    (server-start))
  (when (display-graphic-p)
    (add-to-list 'default-frame-alist '(font . "Source Han Code JP 12"))
    (set-face-attribute 'default nil :font "Source Han Code JP 12")))
)

(my:disable-builtin-mode 'tool-bar-mode)
(my:disable-builtin-mode 'scroll-bar-mode)
(my:disable-builtin-mode 'menu-bar-mode)
(my:disable-builtin-mode 'blink-cursor-mode)
(my:disable-builtin-mode 'column-number-mode)

(show-paren-mode +1)
(setq show-paren-style 'mixed)
(fset 'yes-or-no-p 'y-or-n-p)
(setq read-file-name-completion-ignore-case t)
(setq next-line-add-newlines nil)
(setq make-backup-files nil)
(setq vc-follow-syslinks t)
(global-auto-revert-mode 1)

		  
