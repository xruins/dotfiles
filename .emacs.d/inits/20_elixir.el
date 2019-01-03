(use-package elixir-mode
  :ensure t
  :defer t
  :mode
  ("\\.exs?$" . go-mode)
  :commands
  (elixir-mode)
   :bind
   (:map go-mode-map
   	("M-." . godef-jump)
   	("C-c C-r" . go-remove-unused-imports)
   	("C-c i" . go-goto-imports)
   	("C-c d" . godoc)
   	("C-c l" . golint))
  :init
  ;; (add-hook 'go-mode-hook
  ;; 	    (lambda ()
  ;; 	      (setq tab-width 4)
  ;; 	      (setq c-basic-offset 4)
  ;; 	      (setq indent-tabs-mode t)
  ;; 	      (if (not (string-match "go" compile-command))
  ;; 		  (set (make-local-variable 'compile-command)
  ;; 		       "go generate && go build -v && go test -v && go vet"))
  ;; 	      (company-mode)
  ;; 	      (go-eldoc-setup)
  ;; 	      (go-guru-hl-identifier-mode)))
  :config
  (use-package alchemist
    :ensure t)
  (use-package ac-alchemist
    :ensure t)
  (use-package flycheck-elixir
    :ensure t)
  (use-package 
    :ensure t)
  (use-package go-guru
    :ensure t)
)
