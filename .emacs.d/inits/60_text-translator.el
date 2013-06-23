;;(autoload 'text-translator "text-translator" "Text Translator" t)
(require 'text-translator)

(define-key global-map (kbd "C-c t") 'text-translator)
(define-key global-map (kbd "C-c T") 'text-translator-translate-last-string)

;; プリフィックスキーを変更する場合.
;; (setq text-translator-prefix-key "\M-n")
