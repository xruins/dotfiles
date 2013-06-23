;; ruby-block  endにカーソルを当てると対応する行をハイライトして、
;;             mini-buffer にその内容を表示
;; Thanks to http://shibayu36.hatenablog.com/entry/2013/03/18/192651

(require 'ruby-block)

;; show-paren-mode が競合するので無効化する
(add-hook 'ruby-mode-hook '(lambda () 
                             ;;(ruby-block-mode t)
                             (setq ruby-block-highlight-toggle t)
                             (show-paren-mode nil)
                             ))
