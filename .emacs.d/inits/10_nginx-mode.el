(require 'nginx-mode)
;; 拡張子が conf かつパスにnginx を含むならnginx-modeにする
(add-hook 'conf-mode-hook (lambda () (when (string-match "nginx" (buffer-file-name)) (nginx-mode))))
