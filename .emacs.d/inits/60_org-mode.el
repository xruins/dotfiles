;; org-mode LaTeX のエクスポートのための設定

;; Thanks to http://d.hatena.ne.jp/tamura70/20100217/org
(setq org-export-latex-coding-system 'utf-8-unix) ;; 文字コード
(setq org-export-latex-date-format "%Y年%m月%d日") ;; Date の書式
;; (setq org-export-latex-classes nil)

(require 'org-latex)
(setq org-export-latex-listings t)
;; (add-to-list 'org-export-latex-packages-alist
;;              '(("AUTO" "inputenc" t)))
(add-to-list 'org-export-latex-classes
          '("jarticle"
             "\\documentclass[12pt,a4paper]{jarticle}
             [NO-DEFAULT-PACKAGES]
             [PACKAGES]
             [EXTRA]
\\usepackage[dvipdfmx]{caption}
\\usepackage[dvipdfmx]{hyperref}
"
             ("\\section{%s}" . "\\section*{%s}")
             ("\\subsection{%s}" . "\\subsection*{%s}")
             ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
             ("\\paragraph{%s}" . "\\paragraph*{%s}")
             ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))


;; PDFの出力用コマンドの指定
(setq org-latex-to-pdf-process
      '("platex -interaction=batchmode %f"
        "platex -interaction=batchmode %f"
        "platex -interaction=batchmode %f"
        "dvipdfmx %b")
      )

;; dvipdfmx のワーニングを抑制
;; (setq org-export-latex-default-packages-alist
;;       '(("AUTO" "inputenc"  t)
;;         ("T1"   "fontenc"   t)
;;         (""     "fixltx2e"  nil)
;;         (""     "graphicx"  t)
;;         (""     "longtable" nil)
;;         (""     "float"     nil)
;;         (""     "wrapfig"   nil)
;;         (""     "soul"      t)
;;         (""     "textcomp"  t)
;;         (""     "marvosym"  t)
;;         (""     "wasysym"   t)
;;         (""     "latexsym"  t)
;;         (""     "amssymb"   t)
;;         ("dvipdfmx"     "hyperref"  nil)
;;         "\\tolerance=1000"
;;         )
;;       )
