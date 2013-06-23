;;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
     (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
         (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
             (normal-top-level-add-subdirs-to-load-path))))))

;;; ディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "plugins")
(add-to-load-path "elpa")
(add-to-load-path "auto-install")

;; init-loader の設定
(require 'init-loader)
(init-loader-load "~/.emacs.d/inits")

;; エラー発生時にどのファイルがエラーを起こしたかわかるようにする
;; Thanks to http://d.hatena.ne.jp/kitokitoki/20101205/p1
(defun init-loader-re-load (redir &optional sort)
  (let ((load-path (cons dir load-path)))
    (dolist (el (init-loader--re-load-files re dir sort))
      (condition-case e
	  (let ((time (car (benchmark-run (load (file-name-sans-extension el))))))
	    (init-loader-log (format "loaded %s. %s" (locate-library el) time)))
	(error
	 ;; (init-loader-error-log (error-message-string e)) ；削除
	 (init-loader-error-log (format "%s. %s" (locate-library el) (error-message-string e))) ;追加
	 )))))
