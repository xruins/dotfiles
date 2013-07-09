;; anything

(defvar org-directory "")
(require 'anything)
(require 'anything-config)
(require 'anything-match-plugin)
(require 'anything-complete)
(anything-read-string-mode 1)
(require 'anything-show-completion)
(define-key global-map (kbd "C-x C-f") 'anything-custom-filelist)
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)


;; (defun anything-custom-filelist ()
;;     (interactive)
;;     (anything-other-buffer
;;      (append
;;       '(anything-c-source-ffap-line
;;         anything-c-source-ffap-guesser
;;         anything-c-source-buffers+
;;         )
;;       (anything-c-sources-git-project-for)
;;       '(anything-c-source-recentf
;;         anything-c-source-bookmarks
;;         anything-c-source-file-cache
;;         anything-c-source-filelist
;;         ))
;;      "*anything file list*"))
