;; package.el
;; emacs の elisp のパッケージ管理システム
;; リポジトリとして marmalade, melpa を追加
(require 'package)
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/")
         '("melpa" . "http://melpa.milkbox.net/packages/"))
