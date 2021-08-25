;; initialize use-package
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

(if (not (package-installed-p 'use-package))
    (progn
      (package-refresh-contents)
      (package-install 'use-package)))
(require 'use-package)


;; foundamental settings
(use-package server
  :ensure t
  :config
  (unless (server-running-p)
    (server-start))
  )

(menu-bar-mode -1)
(show-paren-mode 1)
(setq show-paren-style 'mixed)
(fset 'yes-or-no-p 'y-or-n-p)
(setq read-file-name-completion-ignore-case t)
(setq next-line-add-newlines nil)
(setq make-backup-files nil)
(setq vc-follow-syslinks t)
(global-auto-revert-mode 1)
(setq gc-cons-threshold (* gc-cons-threshold 10))
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize)
  )

(setq ring-bell-function 'ignore)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)

(setq-default indent-tabs-mode nil)

;; modifier key
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))

;; keybinds
(define-key global-map (kbd "C-h") 'left-char)
(define-key global-map (kbd "C-j") 'next-line)
(define-key global-map (kbd "C-k") 'previous-line)
(define-key global-map (kbd "C-l") 'right-char)

(define-key global-map (kbd "C-z") 'other-window)
(define-key global-map (kbd "C-t") 'other-window)

;; lsp / company
(use-package lsp-mode
  :ensure t
  :custom ((lsp-inhibit-message t)
           (lsp-message-project-root-warning t)
           (create-lockfiles nil)
           (lsp-prefer-flymake 'flymake)
           (lsp-auto-guess-root t)
           (lsp-response-timeout 5)
           )
  :hook
  (prog-major-mode . lsp-prog-major-mode-enable)
  (go-mode . lsp-buffer-deferred)
  (lsp-mode . lsp-ui-mode)
  (lsp-managed-mode . (lambda () (setq-local company-backends '(company-capf))))
  :commands (lsp lsp-deferred))

(use-package company
  :ensure t
  :custom
  (company-idle-delay 0)
  (company-minimum-prefix-length 1)
  (completion-ignore-case t)
  (company-dabbrev-downcase nil)
  (company-selection-wrap-around t)
  :config
  (global-company-mode))

(use-package lsp-ui
  :ensure t
  :custom
  (lsp-ui-doc-enable t)
  (lsp-ui-doc-header t)
  (lsp-ui-doc-include-signature t)
  (lsp-ui-doc-position 'at-point) ;; top, bottom, or at-point
  (lsp-ui-doc-use-childframe t)
  (lsp-ui-doc-use-webkit t)
;;  (lsp-eldoc-enable-hover t)
;;  (lsp-eldoc-enable-hover t)
  
  ;; lsp-ui-flycheck
  (lsp-ui-flycheck-enable nil)
  
  ;; lsp-ui-peek
  (lsp-ui-peek-enable t)
  (lsp-ui-peek-peek-height 20)
  (lsp-ui-peek-list-width 50)
  (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
  ;; lsp-ui-imenu
  (lsp-ui-imenu-enable t)
  (lsp-ui-imenu-kind-position 'top)
  ;; lsp-ui-sideline
  (lsp-ui-sideline-enable t)
  )

;; major modes
(use-package json-mode
  :ensure t)

(use-package fish-mode
  :ensure t
  :mode ("\\.fish\\'" . fish-mode)
  :hook (fish-mode . (lambda ()
                       (add-hook 'before-save-hook 'fish_indent-before-save))))

(use-package protobuf-mode
  :ensure t)

(use-package yaml-mode
  :ensure t)

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . gfm-mode)
         ("\\.markdown\\'" . gfm-mode))
  :config
  (setq markdown-fontify-code-blocks-natively t))

(use-package elixir-mode
  :ensure t
  :config
  (add-hook 'elixir-mode #'subword-mode))

(use-package dockerfile-mode
  :ensure t
  :mode "/Dockerfile\\'")

(use-package ruby-mode
  :config
  (setq ruby-insert-encoding-magic-comment nil)
  (add-hook 'ruby-mode-hook #'subword-mode))

(use-package go-mode
  :ensure t
  :commands go-mode
  :config
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'go-mode-hook #'lsp))
   
(use-package uniquify
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  ;; rename after killing uniquified
  (setq uniquify-after-kill-buffer-p t)
  ;; don't muck with special buffers
  (setq uniquify-ignore-buffers-re "^\\*"))

(use-package anzu
  :ensure t
  :bind (("C-r" . anzu-query-replace)
         ("C-S-r" . anzu-query-replace-regexp))
  :config
  (global-anzu-mode))

(use-package magit
  :ensure t
  :bind
  ("C-c m" . magit-status))

(use-package paren
  :ensure t
  :hook
  (after-init . show-paren-mode)
  :custom-face
  (show-paren-match ((nil (:background "#44475a" :foreground "#f1fa8c"))))
  :custom
  (show-paren-style 'mixed)
  (show-paren-when-point-inside-paren t)
  (show-paren-when-point-in-periphery t))


(use-package solarized-theme
  :ensure t
  :init
  (load-theme 'solarized-dark t)
  :config
  (setq solarized-distinct-fringe-background t)
  (setq solarized-high-contrast-mode-line t))

(if (version<= "26.0.50" emacs-version)
    (global-display-line-numbers-mode))

(use-package highlight-indent-guides
  :ensure t
  :diminish
  :hook
  ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character))

(use-package rainbow-delimiters
  :ensure t
  :hook
    (prog-mode . rainbow-delimiters-mode))

(use-package git-gutter
  :ensure t
  :custom
  (git-gutter:modified-sign " ")
  (git-gutter:added-sign    " ")
  (git-gutter:deleted-sign  " ")
  :custom-face
  (git-gutter:modified ((t (:background "purple"))))
  (git-gutter:added    ((t (:background "green"))))
  (git-gutter:deleted  ((t (:background "red"))))
  :config  
  (global-git-gutter-mode +1))

(provide 'init)
