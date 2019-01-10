(use-package helm
  :ensure t
  :bind (("M-x" . helm-M-x)
         ("C-x C-f" . helm-find-files)
         ("C-x f" . helm-recentf)
         ;; ("C-SPC" . helm-dabbrev)
         ;; ("M-y" . helm-show-kill-ring)
         ("C-x b" . helm-buffers-list))
  :bind (:map helm-map
	      ("C-k" . helm-previous-line)
	      ("C-j" . helm-next-line)
	      ("C-p" . helm-previous-page)
	      ("C-n" . helm-next-page)
	      ("C-a" . helm-beginning-of-buffer)
	      ("C-e" . helm-end-of-buffer))
  :config (progn
	    (setq helm-buffers-fuzzy-matching t)
