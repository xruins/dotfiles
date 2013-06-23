;; org-mode LaTeX のエクスポートのための設定
;; Thanks to http://d.hatena.ne.jp/tamura70/20100217/org
(setq org-export-latex-coding-system 'utf-8-unix) ;; 文字コード
(setq org-export-latex-date-format "%Y年%m月%d日") ;; Date の書式
(setq org-export-latex-classes nil)
(add-to-list 'org-export-latex-classes ;; jarticle への対応
  '("jarticle"
    "\\documentclass[a4j]{jarticle}"
    ("\\section{%s}" . "\\section*{%s}")
    ("\\subsection{%s}" . "\\subsection*{%s}")
    ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
    ("\\paragraph{%s}" . "\\paragraph*{%s}")
    ("\\subparagraph{%s}" . "\\subparagraph*{%s}")
))
