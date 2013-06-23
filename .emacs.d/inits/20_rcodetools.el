;; r-sense
;; ruby の開発支援いろいろ
;; Thanks to http://blog.10rane.com/tech/tag/rcodetools/

(setq rsense-home (expand-file-name "~/dotfiles/.emacs.d/plugins/rsense-0.3"))
(add-to-list 'load-path (concat rsense-home "/etc"))
(require 'rsense)
(add-hook 'ruby-mode-hook
      (lambda ()
            (add-to-list 'ac-sources 'ac-source-rsense-method)
            (add-to-list 'ac-sources 'ac-source-rsense-constant)))
