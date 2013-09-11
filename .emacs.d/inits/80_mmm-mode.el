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

;; Setting for erb (electric Ruby)

(mmm-add-classes
 '((erb-code
    :submode ruby-mode
    :match-face (("<%#" . mmm-comment-submode-face)
                  ("<%=" . mmm-output-submode-face)
                   ("<%"  . mmm-code-submode-face))
    :front "<%[#=]?"
    :back "%>"
    :insert ((?% erb-code       nil @ "<%"  @ " " _ " " @ "%>" @)
                  (?# erb-comment    nil @ "<%#" @ " " _ " " @ "%>" @)
                       (?% erb-expression nil @ "<%=" @ " " _ " " @ "%>" @))
    )))

(mmm-add-classes
 '((gettext
    :submode gettext-mode
    :front "_(['\']"
    :face mmm-special-submode-face
    :back "[\"'])")))

(mmm-add-classes
 '((html-script
    :submode javascript-mode
    :front "<script>"
    :back  "</script>")))

(add-to-list 'auto-mode-alist '("\\.erb$" . html-mode))

(add-hook 'html-mode-hook
            (lambda ()
               (setq mmm-classes '(erb-code html-js html-script gettext embedded-css))
                (mmm-mode-on)))

(add-to-list 'mmm-mode-ext-classes-alist '(ruby-mode nil gettext))

(global-set-key [f8] 'mmm-parse-buffer)

;; CSS in html

(mmm-add-classes

'((css-in-html

:submode css-mode

:front "<style[^>]*>\n\n</style>")))

(mmm-add-mode-ext-class nil "\\.s?html?\\(\\..+\\)?$" 'css-in-html)


;; decoration-level: 1 の時に使用されるface
(set-face-background 'mmm-default-submode-face "gray15")
