
;; flymakeパッケージを読み込み
(require 'flymake)
;; C,C++,CCモードでのflymakeを有効化
(add-hook 'c-mode-hook '(lambda () (flymake-mode t)))
(add-hook 'cc-mode-hook '(lambda () (flymake-mode t)))
(add-hook 'c++-mode-hook '(lambda () (flymake-mode t)))

;; flymakeの色を変更
(set-face-background 'flymake-errline "red4")
(set-face-background 'flymake-warnline "dark slate blue")

(defun flymake-simple-generic-init (cmd &optional opts)
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                      'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list cmd (append opts (list local-file)))))

;; (defun flymake-simple-make-or-generic-init (cmd &optional opts)
;;   (if (file-exists-p "Makefile")
;;       (flymake-simple-make-init)
;;     (flymake-simple-generic-init cmd opts)))

(require 'popup)
;; flymake 現在行のエラーをpopup.elのツールチップで表示する
(defun flymake-display-err-menu-for-current-line ()
  (interactive)
  (let* ((line-no             (flymake-current-line-no))
         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no))))
    (when line-err-info-list
      (let* ((count           (length line-err-info-list))
             (menu-item-text  nil))
        (while (> count 0)
          (setq menu-item-text (flymake-ler-text (nth (1- count) line-err-info-list)))
          (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
                 (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
            (if file
                (setq menu-item-text (concat menu-item-text " - " file "(" (format "%d" line) ")"))))
          (setq count (1- count))
          (if (> count 0) (setq menu-item-text (concat menu-item-text "\n")))
          )
        (popup-tip menu-item-text)))))

(global-set-key (kbd "M-n") 'flymake-goto-next-error)
(global-set-key (kbd "M-p") 'flymake-goto-prev-error)

(defadvice flymake-goto-prev-error (after flymake-goto-prev-error-display-message)
  (flymake-display-err-menu-for-current-line))
(defadvice flymake-goto-next-error (after flymake-goto-next-error-display-message)
  (flymake-display-err-menu-for-current-line))

(ad-activate 'flymake-goto-prev-error 'flymake-goto-prev-error-display-message)
(ad-activate 'flymake-goto-next-error 'flymake-goto-next-error-display-message)






