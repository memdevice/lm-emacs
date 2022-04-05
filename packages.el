;;;;;;            packages.el                                              ;;;;;;

;; Time-stamp: <2022-03-29 17:47:34 f205200>

;;;;;;            packages.el                                              ;;;;;;




;;  —————————————————————————————————————————————————————————————————————————  ;;

(require 'deft)
(setq deft-directory "~/deft")
;;(setq deft-recursive t)
;; (setq deft-extensions '("txt" "tex" "org"))
;; (global-set-key (kbd "C-x C-g") 'deft-find-file)

;; (setq deft-text-mode 'org-mode)
;; AND
;; (setq deft-extension "org")
;; OR
;; (add-to-list 'auto-mode-alist '("notes/.*[.]txt$" . org-mode))

;; alternativa

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; deft                                                                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; (require 'deft)
;; (setq deft-directory "~/docs/deft")
;; (setq deft-extensions '("org"))
;; (setq deft-default-extension "org")
;; (setq deft-text-mode 'org-mode)
;; (setq deft-use-filename-as-title t)
;; (setq deft-use-filter-string-for-filename t)
;; (setq deft-auto-save-interval 0)
;; ;;key to launch deft
;; (global-set-key (kbd "C-c d") 'deft)

;; For compatibility with other applications which use the filename as the title of a note (rather than the first line of the file), set the deft-use-filename-as-title flag to a non-nil value. Deft will then use note filenames to generate the displayed titles in the Deft file browser. To enable this, add the following to your .emacs file:

;; (setq deft-use-filename-as-title t)

;; LM importante!!

;; As an example, with the following value for deft-file-naming-rules, Deft will replace all slashes and spaces with hyphens and will convert the file name to lowercase:

;; (setq deft-file-naming-rules
;;       '((noslash . "-")
;;         (nospace . "-")
;;         (case-fn . downcase)))

;; Deft is an Emacs mode for quickly browsing, filtering, and editing directories of plain text notes, inspired by Notational Velocity. It was designed for increased productivity when writing and taking notes by making it fast and simple to find the right file at the right time and by automating many of the usual tasks such as creating new files and saving files.

;; Overview

;;The Deft buffer is simply a file browser which lists the titles of all text files in the Deft directory followed by short summaries and last modified times. The title is taken to be the first line of the file and the summary is extracted from the text that follows. Files are, by default, sorted in terms of the last modified date, from newest to oldest.

;; All Deft files or notes are simple plain text files where the first line contains a title. As an example, the following directory structure generated the screenshot above.

;; Deft’s primary operation is searching and filtering
;; To open the first matching file, simply press RET.
;; To open files other than the first match, navigate up and down using C-p and C-n and press RET
;; You can also press C-o to open a file in another window, without switching to the other window. Issue the same command with a prefix argument, C-u C-o, to open the file in another window and switch to that window.

;; To edit the filter string, press DEL (backspace) to remove the last character or M-DEL to remove the last “word”.

;; Press C-c C-c to clear the filter string and display all files and C-c C-g to refresh the file browser using the current filter string.

;; For more advanced editing operations, you can also edit the filter string in the minibuffer by pressing C-c C-l.

;; Basic customization

;; (setq deft-extensions '("txt" "tex" "org"))
;; (setq deft-directory "~/Dropbox/notes")

;; By default, Deft only searches for files in deft-directory but not in any subdirectories.
;; (setq deft-recursive t)
;; You can easily set up a global keyboard binding for Deft. For example, to bind it to F8, add the following code to your .emacs file:
;; (global-set-key [f8] 'deft)

;; (global-set-key (kbd "C-x C-g") 'deft-find-file)

;; cfr.: https://jblevins.org/projects/deft/

;; Helpful keybindings

;; In the "*Deft*" buffer you can start typing to filter the list of notes.

;; [C-c C-c]
;; clear the filter

;; [C-c C-n]
;; quickly create a new note

;;Use Org for Deft Files

;; To use Org mode for your Deft files, add the following to your Emacs configuration file:

;; (setq deft-text-mode 'org-mode)

;; Then do one of the following:

;; Configure Deft to use .org as the file extension:
;; (setq deft-extension "org")
;; Associate Org mode with .txt files, or just with .txt files in a specific directory (e.g. notes/ as shown here)
;; (add-to-list 'auto-mode-alist '("notes/.*[.]txt$" . org-mode))

;;  —————————————————————————————————————————————————————————————————————————  ;;

;; using thesaurus offline in d:\home\dict
(require 'mthesaur)

;; [mthesaur]
(global-set-key (kbd "C-c t")   'mthesaur-search)
;;(global-set-key (kbd "C-c C-t") 'mthesaur-search-append)

;;  —————————————————————————————————————————————————————————————————————————  ;;

;; (require 'sinvirt)           ;; sinvirt!
;; (require 'mpwgen)            ;; genratore di password pronunciabili (by EXE)

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

;; columnize

;; See C-h f columnize-text <ret> for a complete description.
(autoload 'columnize-text "columnize"
          "Formats a list of items into columns (pillars)" t)
    (load "columnize" nil t)
;; Optionally add a key mapping like this.
;; (global-set-key [?\C-x ?c] 'columnize-text)

(global-set-key (kbd "C-x c")  'columnize-text)

;;  —————————————————————————————————————————————————————————————————————————  ;;

(global-set-key "\M-+" 'word-count-mode)

(autoload 'word-count-mode "word-count"
           "Minor mode to count words." t nil)

;;  —————————————————————————————————————————————————————————————————————————  ;;
