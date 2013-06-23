
(which-func-mode 1)
(setq which-func-modes t)

(delete (assoc 'which-func-mode mode-line-format) mode-line-format)
(setq-default header-line-format '(which-func-mode ("" which-func-format)))
