;; initialize use-package
(require 'package)
(add-to-list 'package-archives '("melpa"."http://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; foundamental settings
(use-package server
  :ensure t
  :config
  (unless (server-running-p)
    (server-start))
  )

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror)

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
  (add-hook 'go-mode-hook (lambda()
                            (company-mode)
                            (setq company-transformers '(company-sort-by-backend-importance)) ;; ソート順
                            (setq company-idle-delay 0) ; 遅延なしにすぐ表示
                            (setq company-minimum-prefix-length 3) ; デフォルトは4
                            (setq company-selection-wrap-around t) ; 候補の最後の次は先頭に戻る
                            (setq completion-ignore-case t)
                            (setq company-dabbrev-downcase nil)
                            (global-set-key (kbd "C-M-i") 'company-complete)
                            ;; C-n, C-pで補完候補を次/前の候補を選択
                            (define-key company-active-map (kbd "C-n") 'company-select-next)
                            (define-key company-active-map (kbd "C-p") 'company-select-previous)
                            (define-key company-active-map (kbd "C-s") 'company-filter-candidates) ;; C-sで絞り込む
                            (define-key company-active-map [tab] 'company-complete-selection) ;; TABで候補を設定
                            (define-key emacs-lisp-mode-map (kbd "C-M-i") 'company-complete) ;; 各種メジャーモードでも C-M-iで company-modeの補完を使う
                            ))	
  (add-hook 'go-mode-hook
	    (lambda ()
	      (setq tab-width 4)
	      (setq c-basic-offset 4)
	      (setq indent-tabs-mode t)
	      (if (not (string-match "go" compile-command))
		  (set (make-local-variable 'compile-command)
		       "go generate && go build -v && go test -v && go vet"))
	      (company-mode)
	      ;;(go-guru-hl-identifier-mode)
	      )
	    )
  :config
  (use-package company-go
    :ensure t)
  (use-package golint
    :ensure t)
  (add-hook 'before-save-hook 'gofmt-before-save)
  (add-hook 'before-save-hook 'gofmt-before-save)
  )

;; minor modes
(use-package linum
   :ensure t
   :hook
   (prog-mode . linum-mode)
   :config
   (setq linum-format "%4d "))

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

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-popup-tip
  :ensure t
  :config
  (with-eval-after-load 'flycheck
    '(add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode)))

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
  :hook
  (prog-mode . rainbow-mode))

(use-package magit
  :ensure t
  :bind
  ("C-c m" . magit-status))

(use-package lsp-mode
  :custom
  ;; debug
  (lsp-print-io nil)
  (lsp-trace nil)
  (lsp-print-performance nil)
  ;; general
  (lsp-auto-guess-root t)
  (lsp-document-sync-method 'incremental) ;; always send incremental document
  (lsp-response-timeout 5)
  (lsp-prefer-flymake 'flymake)
  (lsp-enable-completion-at-point nil)
  :hook
  (go-mode . lsp)
  :bind
  (:map lsp-mode-map
        ("C-c r"   . lsp-rename))
  :config
  (require 'lsp-clients)
  ;; LSP UI tools
  (use-package lsp-ui
    :custom
    ;; lsp-ui-doc
    (lsp-ui-doc-enable t)
    (lsp-ui-doc-header t)
    (lsp-ui-doc-include-signature t)
    (lsp-ui-doc-position 'top) ;; top, bottom, or at-point
    (lsp-ui-doc-max-width 150)
    (lsp-ui-doc-max-height 30)
    (lsp-ui-doc-use-childframe t)
    (lsp-ui-doc-use-webkit t)
    ;; lsp-ui-flycheck
    (lsp-ui-flycheck-enable nil)
    ;; lsp-ui-sideline
    (lsp-ui-sideline-enable nil)
    (lsp-ui-sideline-ignore-duplicate t)
    (lsp-ui-sideline-show-symbol t)
    (lsp-ui-sideline-show-hover t)
    (lsp-ui-sideline-show-diagnostics nil)
    (lsp-ui-sideline-show-code-actions nil)
    ;; lsp-ui-imenu
    (lsp-ui-imenu-enable nil)
    (lsp-ui-imenu-kind-position 'top)
    ;; lsp-ui-peek
    (lsp-ui-peek-enable t)
    (lsp-ui-peek-peek-height 20)
    (lsp-ui-peek-list-width 50)
    (lsp-ui-peek-fontify 'on-demand) ;; never, on-demand, or always
    :preface
    (defun ladicle/toggle-lsp-ui-doc ()
      (interactive)
      (if lsp-ui-doc-mode
          (progn
            (lsp-ui-doc-mode -1)
            (lsp-ui-doc--hide-frame))
        (lsp-ui-doc-mode 1)))
    :bind
    (:map lsp-mode-map
          ("C-c C-r" . lsp-ui-peek-find-references)
          ("C-c C-j" . lsp-ui-peek-find-definitions)
          ("C-c i"   . lsp-ui-peek-find-implementation)
          ("C-c m"   . lsp-ui-imenu)
          ("C-c s"   . lsp-ui-sideline-mode)
          ("C-c d"   . ladicle/toggle-lsp-ui-doc))
    :hook
    (lsp-mode . lsp-ui-mode))
  ;; Lsp completion
  (use-package company-lsp
    :custom
    (company-lsp-cache-candidates t) ;; always using cache
    (company-lsp-async t)
    (company-lsp-enable-recompletion nil)))

(use-package highlight-indent-guides
  :ensure t
  :diminish
  :hook
  ((prog-mode yaml-mode) . highlight-indent-guides-mode)
  :custom
  (highlight-indent-guides-auto-enabled t)
  (highlight-indent-guides-responsive t)
  (highlight-indent-guides-method 'character)) ; column

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

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

(use-package which-key
  :ensure t
  :diminish which-key-mode
  :hook (after-init . which-key-mode))

(use-package amx
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package counsel
  :ensure t
  :bind
  (:map counsel-mode-map
        ("C-c g" . counsel-git)
        ("C-c j" . counsel-git-grep)
        ("C-c a" . counsel-ag)
        )
  :hook
  (prog-mode . counsel-mode))

(use-package flycheck-popup-tip
  :ensure t
  :config
  (with-eval-after-load 'flycheck
    '(add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode))
  )


