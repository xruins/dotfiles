;; initialize use-package
(require 'package)
(add-to-list 'package-archives '("melpa"."http://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))


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

(setq ring-bell-function 'ignore)

(setq scroll-margin 0
      scroll-conservatively 100000
      scroll-preserve-screen-position 1)
(setq-default indent-tabs-mode nil)

(use-package solarized-theme
  :ensure t
  :custom
  (solarized-use-variable-pitch nil)
  (x-underline-at-descent-line t)
  :init
  (load-theme 'solarized-dark t))

;;;; modifier keys
(when (eq system-type 'darwin)
  (setq ns-command-modifier (quote meta)))

;;;; keybinds
(global-set-key (kbd "C-h") 'left-char)
(global-set-key (kbd "C-j") 'next-line)
(global-set-key (kbd "C-k") 'previous-line)
(global-set-key (kbd "C-l") 'right-char)

(define-key global-map (kbd "C-z") 'other-window)
(define-key global-map (kbd "C-t") 'other-window)

(use-package linum
  :ensure t
  :init
  (global-linum-mode 1)
  (setq linum-format "%4d ")
  )

(use-package yasnippet
  :ensure t
  :diminish yas-minor-mode
  :bind (("C-c y i" . yas-insert-snippet)
	 ("C-c y n" . yas-new-snippet)
	 ("C-c y v" . yas-visit-snippet-file))
  :init
  (add-hook 'after-init-hook 'yas-global-mode)
  :config
  (setq yas-snippet-dirs
	'("~/.emacs.d/snippets/"))
  (setq yas-prompt-functions '(yas-ido-prompt))
  :commands
  (yas-minor-mode yas-global-mode))


(use-package company
  :ensure t
  :config
  (setq company-transformers '(company-sort-by-backend-importance))
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 3) 
  (setq company-selection-wrap-around t)
  (setq completion-ignore-case t)
  (setq company-dabbrev-downcase nil)
  (setq company-tooltip-align-annotations t)
  (setq company-tooltip-flip-when-above t)
  (define-key company-active-map (kbd "C-n") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "C-j") 'company-select-next) ;; C-n, C-pで補完候補を次/前の候補を選択
  (define-key company-active-map (kbd "C-k") 'company-select-previous)
  (define-key company-search-map (kbd "C-j") 'company-select-next)
  (define-key company-search-map (kbd "C-k") 'company-select-previous)
  (global-company-mode)
  :ensure t
  )
(use-package flyspell
  :if
  (executable-find "aspell")
  :config
  (setq ispell-program-name "aspell" ; use aspell instead of ispell
        ispell-extra-args '("--sug-mode=ultra"))
  (add-hook 'text-mode-hook #'flyspell-mode)
  (add-hook 'prog-mode-hook #'flyspell-prog-mode))

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

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

(use-package rainbow-delimiters
  :ensure t)

(use-package rainbow-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-mode))

(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

(use-package git-timemachine
  :ensure t
  :bind (("s-g" . git-timemachine)))

(use-package ruby-mode
  :config
  (setq ruby-insert-encoding-magic-comment nil)
  (add-hook 'ruby-mode-hook #'subword-mode))

(use-package go-mode
  :ensure t
  :defer t
  :mode
  ("\\.go$" . go-mode)
  :commands
  (go-mode)
  :bind
  (:map go-mode-map
	("M-." . godef-jump)
	("C-c C-r" . go-remove-unused-imports)
	("C-c i" . go-goto-imports)
	("C-c d" . godoc)
	("C-c l" . golint))
  :init
  (add-hook 'go-mode-hook
	    (lambda ()
	      (setq tab-width 4)
	      (setq c-basic-offset 4)
	      (setq indent-tabs-mode t)
	      (if (not (string-match "go" compile-command))
		  (set (make-local-variable 'compile-command)
		       "go generate && go build -v && go test -v && go vet"))
	      ;;(company-mode)
	      ;;(go-guru-hl-identifier-mode)
	      )
	    )
  :config
  (use-package company-go
    :ensure t)
  (use-package golint
    :ensure t)
  (add-hook 'before-save-hook 'lsp-format-buffer)
  (add-hook 'before-save-hook 'gofmt-before-save)
  )

(use-package lsp-go
  :after (lsp-mode go-mode)
  :custom (lsp-go-language-server-flags '(
                                          "-gocodecompletion"
                                          "-diagnostics"
                                          "-lint-tool=golint"))
  :hook (go-mode . lsp-go-enable)
  :commands lsp-go-enable)

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

;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (golint company-go dockerfile-mode elixir-mode markdown-mode yaml-mode protobuf-mode fish-mode json-mode go-mode git-timemachine magit rainbow-mode rainbow-delimiters anzu flycheck company yasnippet solarized-theme use-package)))
 '(solarized-use-variable-pitch nil)
 '(x-underline-at-descent-line t t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
