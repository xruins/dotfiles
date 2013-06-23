;; mmm-mode in php
(require 'mmm-mode)
(setq mmm-global-mode 'maybe)

;; for between html and php
;; (mmm-add-mode-ext-class nil "\\.php?\\'" 'html-php)
;; (mmm-add-classes
;;  '((html-php
;;     :submode php-mode
;;     :front "<\\?\\(php\\)?"
;;     :back "\\?>")))
;; (add-to-list 'auto-mode-alist '("\\.php?\\'" . xml-mode))


(setq mmm-submode-decoration-level 2)

(set-face-background 'mmm-default-submode-face "gray15")

;; js in html

(mmm-add-classes

'((js-in-html

:submode js-mode

:front "<script[^>]*>\n\n</script>")))

(mmm-add-mode-ext-class nil "\\.s?html?\\(\\..+\\)?$" 'js-in-html)

;; css in html

(mmm-add-classes

'((css-in-html

:submode css-mode

:front "<style[^>]*>\n\n</style>")))

(mmm-add-mode-ext-class nil "\\.s?html?\\(\\..+\\)?$" 'css-in-html)


;; decoration-level: 1 の時に使用されるface
(set-face-background 'mmm-default-submode-face "gray15")
