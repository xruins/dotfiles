(menu-bar-mode -1)
(show-paren-mode 1)
(setq show-paren-style 'mixed)
(fset 'yes-or-no-p 'y-or-n-p)
(setq read-file-name-completion-ignore-case t)
(setq next-line-add-newlines nil)
(setq make-backup-files nil)
(setq vc-follow-syslinks t)
(global-auto-revert-mode 1)

(require 'package)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;;;; add melpa and orgmode for packages
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa" . "http://melpa.org/packages/")
	("org" . "http://orgmode.org/elpa/")))

(unless package-archive-contents
  (package-refresh-contents))

;;;;; ensure to use use-package
(when (not (package-installed-p 'use-package))
  (package-install 'use-package))
(require 'use-package)

(use-package server
  :ensure t
  :config
  (unless (server-running-p)
    (server-start))
  )

;;;;; change the place for Custom
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

(use-package auto-complete-config
  :ensure auto-complete
  :init
  (global-auto-complete-mode 1)
  )

(use-package solarized-theme
;;  :custom
;;  (solarized-use-variable-pitch nil)
;;  (x-underline-at-descent-line t)
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
  (global-linum-mode 1))

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

(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ;; ("C-SPC" . helm-dabbrev)
         ;; ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-buffers-list))
  :bind (:map helm-map
	      ("C-k" . helm-previous-line)
	      ("C-j" . helm-next-line)
	      ("C-p" . helm-previous-page)
	      ("C-n" . helm-next-page)
	      ("C-a" . helm-beginning-of-buffer)
	      ("C-e" . helm-end-of-buffer))
  :config (progn
	    (setq helm-buffers-fuzzy-matching t)
	    (use-package yaml-mode
	      :ensure t
	      :mode ("\\.ya?ml\\'" . yaml-mode))
	    )
  )

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
	      (company-mode)
	      (go-eldoc-setup)
	      (go-guru-hl-identifier-mode)))
  :config
  (use-package company
    :ensure t)
  (use-package company-go
    :ensure t)
  (use-package flycheck
    :ensure t)
  (use-package go-eldoc
    :ensure t)
  (use-package golint
    :ensure t)
  (use-package go-guru
    :ensure t)
  (use-package lsp-go
    :after (lsp-mode go-mode)
    :custom (lsp-go-language-server-flags '(
					    "-gocodecompletion"
					    "-diagnostics"
					    "-lint-tool=golint"))
    :hook (go-mode . lsp-go-enable)
    :commands lsp-go-enable)
  (global-flycheck-mode)
  (setq godef-command "godef")
  (setq gofmt-command "gofmt")
  (setq go-guru-debug t)
  (setq company-go-show-annotation t)
  (setq flycheck-check-syntax-automatically t)
  (add-to-list 'company-backends '(company-go :with company-dabbrev-code))
  (setq company-transformers '(company-sort-by-backend-importance))
  (add-hook 'before-save-hook 'gofmt-before-save)
  )

(use-package json-mode)

(use-package markdown-mode)

(use-package protobuf-mode)
(use-package ruby-mode)
(use-package toml-mode)
(use-package yaml-mode)
