;; スクリプトの先頭に #! が含まれているとき、自動で実行権限を付与
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; byte-compile 時の警告を抑制
(setq byte-compile-warnings '(free-vars unresolved callargs redefine obsolete noruntime cl-functions interactive-only make-local))


