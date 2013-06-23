;;; isearch+-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (isearch-mode-help isearch-toggle-case-fold isearchp-set-region-around-search-target
;;;;;;  isearchp-toggle-set-region isearchp-toggle-regexp-quote-yank
;;;;;;  isearchp-toggle-invisible isearchp-mouse-2-flag isearchp-set-region-flag
;;;;;;  isearchp-regexp-quote-yank-flag) "isearch+" "isearch+.el"
;;;;;;  (20859 62629))
;;; Generated autoloads from isearch+.el

(defvar isearchp-regexp-quote-yank-flag t "\
*Non-nil means escape special chars in text yanked for a regexp isearch.
You can toggle this with `isearchp-toggle-regexp-quote-yank', bound to
`C-`' during isearch.")

(custom-autoload 'isearchp-regexp-quote-yank-flag "isearch+" t)

(defvar isearchp-set-region-flag nil "\
*Non-nil means set region around search target.
This is used only for Transient Mark mode.
You can toggle this with `isearchp-toggle-set-region', bound to
`C-SPC' during isearch.")

(custom-autoload 'isearchp-set-region-flag "isearch+" t)

(defvar isearchp-mouse-2-flag t "\
*Non-nil means clicking `mouse-2' during Isearch yanks the selection.
In that case, you can select text with the mouse, then hit `C-s' to
search for it.

If the value is nil, yank only if the `mouse-2' click is in the echo
area.  If not in the echo area, invoke whatever `mouse-2' is bound to
outside of Isearch.")

(custom-autoload 'isearchp-mouse-2-flag "isearch+" t)

(autoload 'isearchp-toggle-invisible "isearch+" "\
Toggle `search-invisible'.

\(fn)" t nil)

(autoload 'isearchp-toggle-regexp-quote-yank "isearch+" "\
Toggle `isearchp-regexp-quote-yank-flag'.

\(fn)" t nil)

(autoload 'isearchp-toggle-set-region "isearch+" "\
Toggle `isearchp-set-region-flag'.

\(fn)" t nil)

(autoload 'isearchp-set-region-around-search-target "isearch+" "\
Set the region around the last search or query-replace target.

\(fn)" t nil)

(autoload 'isearch-toggle-case-fold "isearch+" "\
Toggle case folding in searching on or off.
The minor-mode lighter is `ISEARCH' for case-insensitive, `Isearch'
for case-sensitive.

\(fn)" t nil)

(autoload 'isearch-mode-help "isearch+" "\
Display information on interactive search in buffer *Help*.

\(fn)" t nil)

;;;***

;;;### (autoloads nil nil ("isearch+-pkg.el") (20859 62629 197974))

;;;***

(provide 'isearch+-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; isearch+-autoloads.el ends here
