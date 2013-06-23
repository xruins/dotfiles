;; Ruby-mode の設定
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))

(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2) ;; タブ幅の設定
             (setq ruby-indent-level tab-width) ;; タブ幅設定の適用
             (setq ruby-deep-indent-paren-style nil)
             (define-key ruby-mode-map [return] 'ruby-reindent-then-newline-and-indent)
             )
          )

(defun ruby-reindent-then-newline-and-indent ()
  (interactive)
  (call-interactively 'reindent-then-newline-and-indent)
) 


