;; RCodeTools 
;; Ruby の開発支援環境
;; コード補完、xmpによる簡易実行など
;; Thanks to http://d.hatena.ne.jp/authorNari/20090523/1243051306

(require 'rcodetools)
(setq rct-find-tag-if-available nil)
(defun ruby-mode-hook-rcodetools ()
  (define-key ruby-mode-map "\M-\C-i" 'rct-complete-symbol)
  (define-key ruby-mode-map "\C-c\C-t" 'ruby-toggle-buffer)
  (define-key ruby-mode-map "\C-c\C-d" 'xmp)
  (define-key ruby-mode-map "\C-c\C-f" 'rct-ri))
(add-hook 'ruby-mode-hook 'ruby-mode-hook-rcodetools)

(require 'anything-rcodetools)
(setq rct-get-all-methods-command "PAGER=cat fri -l")
;; See docs
;; (define-key anything-map [(control ?;)] 'anything-execute-persistent-action)


