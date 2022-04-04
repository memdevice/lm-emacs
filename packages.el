;; Time-stamp: <2022-03-09 17:25:42 f205200>


;;  —————————————————————————————————————————————————————————————————————————  ;;

(require 'mpwgen)            ;; genratore di password pronunciabili (by EXE)

;;  —————————————————————————————————————————————————————————————————————————  ;;

;; LM: better REGEXP

;; The backslash madness: I recommend you switch to string right away;
;; there’s little reason to use read, and the extra escaping will
;; drive you insane unless you’re used to writing regexp in elisp.

;; cfr: https://www.masteringemacs.org/article/re-builder-interactive-regexp-builder

;; Useful Keybinds If you do write a lot of elisp, you probably use (or
;; should use!) rx to make your regexp experience in Emacs a bit more
;; pleasant. Unfortunately, you can only have one default setting at a
;; time so you have to switch manually with C-c TAB in re-builder.

;; You can enter the sub-expression mode with C-c C-e to only highlight
;; capturing groups; you can toggle the case sensitivity with C-c C-i;
;; and you can move between matches with C-c C-s and C-c C-r.

;; The re-builder keybind C-c C-w bears mention as well: it will copy
;; (and convert, where applicable) the expression to a string format
;; suitable for use in elisp.
(require 're-builder)
(setq reb-re-syntax 'string)

;; (no file in lisp dir required)

;;  —————————————————————————————————————————————————————————————————————————  ;;

;; non funziona!
;; using thesaurus offline in d:\home\dict
;; (require 'mthesaur)

;; (global-set-key "\C-ct" 'mthesaur-search)
;; conflitto! ;;    (global-set-key "\C-c\C-t" 'mthesaur-search-append)

;;  —————————————————————————————————————————————————————————————————————————  ;;

(autoload 'word-count-mode "word-count"
           "Minor mode to count words." t nil)
(global-set-key "\M-+" 'word-count-mode)

;;  —————————————————————————————————————————————————————————————————————————  ;;

;; il file .el è vuoto...

;;(require 'sinvirt)           ;; sinvirt!
