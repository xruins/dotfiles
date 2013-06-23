
(defun flymake-c-init ()
  (flymake-simple-make-or-generic-init
   "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(push '("\\.c\\'" flymake-c-init) flymake-allowed-file-name-masks)

