;; Smart Compile
;;  M-x compile の強化版
(require 'smart-compile)
(define-key global-map (kbd "C-c c") 'smart-compile)
(define-key global-map (kbd "C-c C-c") (kbd "C-c c C-m"))


(defvar smart-compile-alist '(
  ("\\.c\\'"          . "gcc -O2 %f -lm -o %n")
  ("\\.[Cc]+[Pp]*\\'" . "g++ -O2 %f -lm -o %n")
  ("\\.java\\'"       . "javac %f")
  ("\\.f90\\'"        . "gfortran %f -o %n")
  ("\\.[Ff]\\'"       . "gfortran %f -o %n")
  ("\\.tex\\'"        . (tex-file))
  ("\\.pl\\'"         . "perl -cw %f")
  ("\\.rb\\'"         . "ruby %f")
  (emacs-lisp-mode    . (emacs-lisp-byte-compile))
) "compile command list for smart-compile")
