;; タイトルバーをファイル名に
(setq frame-title-format "%b")

;; ファイル名の大文字と小文字を保管時に区別しない
(setq completion-ignore-case t)

;; 自動再読み込み
(global-auto-revert-mode 1)
;; メニューバーを表示しない
(menu-bar-mode -1)

;; 起動時の画面を表示しない
(setq inhibit-startup-message t)

;; 行数，列数表示
(line-number-mode t)
(column-number-mode t)

;; タブ幅の設定
(setq-default tab-width 4 indent-tabs-mode nil)

;; シンボリックリンクを辿る
(setq vc-follow-symlinks t)

;; 行の折り返し
(setq truncate-partial-width-windows nil)

;; Emacs標準のオートセーブを無効化
(setq backup-inhibited t)
(setq delete-auto-save-files t)

;; #のバックアップファイルを作成しない
(setq make-backup-files nil)

;; 最終行に必ず一行挿入
(setq require-final-newline t)

;; 文字コードの設定(共通)
(set-language-environment       "Japanese")
(prefer-coding-system           'utf-8-unix)


;; 文字コードの設定(環境別)
;; (if (eq system-type 'windows-nt)
;;    (progn
      (set-buffer-file-coding-system  'utf-8-unix)
      (set-terminal-coding-system     'utf-8-unix)
      (set-keyboard-coding-system     'utf-8-unix)
      (set-clipboard-coding-system    'utf-8-unix)
;;     )
;;  )
;;(progn
;;  (set-buffer-file-coding-system  'sjis-dos)
;;  (set-terminal-coding-system     'sjis-dos)
  ;; (set-keyboard-coding-system     'sjis-dos)
  ;; (set-clipboard-coding-system    'sjis-dos)
  ;; ) 
;; ウインドウモードの際の設定
(if window-system
    (progn
      ;; ツールバーを表示しない
      (tool-bar-mode 0)

      ;; スクロールバーを左に表示
      (set-scroll-bar-mode nil)

      ;; 色設定
      (add-to-list 'default-frame-alist '(foreground-color . "ivory"))
      (add-to-list 'default-frame-alist '(background-color . "black"))
      (add-to-list 'default-frame-alist '(cursor-color . "white"))
      (set-face-background 'region "navy")
      ))


;; 対応する括弧をハイライト
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face "gray15")
(set-face-foreground 'show-paren-match-face "white")

;; フォント設定

(set-face-attribute 'default nil
                    :family "Ricty for Powerline"
                    :height 110)
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  (cons "Ricty for Powerline" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0212
                  (cons "Ricty for Powerline" "iso10646-1"))
(set-fontset-font (frame-parameter nil 'font)
                  'katakana-jisx0201
                  (cons "Ricty for Powerline" "iso10646-1"))

;; フレームの設定
(setq default-frame-alist
      (append (list
               '(width . 80)
               '(height . 30)
               ;; '(top . 100)
               ;; '(left . 100)
               ;; '(alpha . 80 50 nil nil))
               '(alpha . (100 80 nil nil))
               )
              default-frame-alist))

;; スペースとタブを表示
(defface my-face-b-1 '((t (:background "gray"))) nil)
(defface my-face-b-2 '((t (:background "gray26"))) nil)
(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
(defvar my-face-b-1 'my-face-b-1)
(defvar my-face-b-2 'my-face-b-2)
(defvar my-face-u-1 'my-face-u-1)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-b-2 append)
     ("　" 0 my-face-b-1 append)
     ("[ \t]+$" 0 my-face-u-1 append))))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; 行末で折り返す
(setq truncate-lines nil)
(setq truncate-partial-width-windows nil)

;; 圧縮されたファイルも編集できるようにする
(auto-compression-mode t)

;; 同名ファイルのバッファ名を識別できるようにする
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; コピーをクリップボードと共有する
(cond (window-system
       (setq x-select-enable-clipboard t)
       ))

;; デフォルトブラウザ変更
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")
(when (eq system-type 'darwin)
  (add-to-list 'exec-path "/usr/local/bin")
  (setq browse-url-browser-function 'browse-url-generic
        browse-url-generic-program "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"))

;; 現在行をハイライトする
;; (defface hlline-face
;;   '((((class color)
;;       (background dark))
;;      (:background "dark slate gray"))
;;     (((class color)
;;       (background light))
;;      (:background  "#98FB98"))
;;     (t
;;      ()))
;;   "*Face used by hl-line.")
;; (setq hl-line-face 'hlline-face)
;; (global-hl-line-mode)

;; バッファ自動再読み込み
(global-auto-revert-mode 1)

;; yes/no を y/n に変更
(fset 'yes-or-no-p 'y-or-n-p)

;; No-Window 下で scroll-bar-mode が正常に機能しない問題の修正
(cond (window-system
       (set-scroll-bar-mode 'right))) 

;; Mini-buffer の文字色の設定
(set-face-foreground 'minibuffer-prompt "cyan1")

;; 名前とメールアドレスの設定
(setq user-full-name "Ruins")
(setq user-mail-address "ruinscorocoro@gmail.com")

;; file名の保管時に大文字、小文字を区別しない
(setq completion-ignore-case t)

;; バッファを自動で再読み込み
(global-auto-revert-mode 1)

;; ビープの無効化
(setq ring-bell-function 'ignore)

;; Windows + window-system におけるクリップボードの文字化け対策
(cond
 (window-system)
 (featurep 'dos-w32)
 (set-clipboard-coding-system 'shift_jis-dos)
 )

;;  mode-line の標準形式の変更
(setq-default mode-line-format
              '("-"
                mode-line-mule-info
                mode-line-modified
                mode-line-frame-identification
                mode-line-buffer-identification
                " "
                global-mode-string
                " %[("
                mode-name
                mode-line-process
;;                 minor-mode-alist
                "%n" ")%]-"
                (which-func-mode ("" which-func-format "-"))
                (line-number-mode "L%l-")
                (column-number-mode "C%c-")
;;                 (-3 . "%p")    ; position 表示はいらないかなっと
                "-%-")
              )
