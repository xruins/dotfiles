
1
;; Vim 風のキャレット移動
(define-key global-map (kbd "C-h") 'left-char)
(define-key global-map (kbd "C-j") 'next-line)
(define-key global-map (kbd "C-k") 'previous-line)
(define-key global-map (kbd "C-l") 'right-char)

;; kill-line を C-n に再配置
(define-key global-map (kbd "C-n") 'kill-line)

;; C-c s でシェルを起動
(define-key global-map (kbd "C-c s") 'shell)


;; C-c C-p i で package-install
(define-key global-map (kbd "C-c C-p i") 'package-install)
;; C-c C-p l で package-list-packages
(define-key global-map (kbd "C-c C-p l") 'package-list-packages)

;; C-x f の無効化
(define-key global-map (kbd "C-x f") 'ignore)
;; C-. で補完の中止
;; (define-key ac-completing-map "\C-." 'ac-stop)
