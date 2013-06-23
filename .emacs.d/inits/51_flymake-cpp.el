
(defun flymake-cc-init ()
  (flymake-simple-make-or-generic-init
   "g++" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(push '("\\.\\(cc\\|cpp\\|C\\|CPP\\|hpp\\)\\'" flymake-cc-init)
      flymake-allowed-file-name-masks)
