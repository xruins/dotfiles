;; Ruby コード上で C-c d を入力すると，行頭からカーソル位置までの Ruby コードを self のメソッドを
;; what_methods にて検索できる．transient-mark-mode がオンのときはリージョンを self としてメソッドの検索を行う．
;; 出力したい内容は，C-c d 入力後にミニバッファに入力する．

;; 例えば，「(1..3)」と記述された行末にカーソルがある状態で C-c d を入力すると，
;; ミニバッファに「’(1..3)’ to: 」と表示される．ここに「[1,2,3]」と入力すれば
;; 「to_a」「entries」「sort」の 3 つの候補が anything バッファに出力される．候補は選択で挿入可能．
;;  Thanks to https://github.com/akisute3/anything-ruby-methods

 (require 'anything-ruby-methods)
 (define-key ruby-mode-map (kbd "C-c d") 'anything-ruby-methods)
