;;;;;;            function.el                                              ;;;;;;

;; Time-stamp: <2022-03-08 14:37:24 f205200>

;;;;;;            function.el                                              ;;;;;;


;;  —————————————————————————————————————————————————————————————————————————  ;;
;;                  from init.el - SMISTA!
;;  —————————————————————————————————————————————————————————————————————————  ;;

(define-key global-map (kbd "M-Q") 'unfill-paragraph)
;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))
;; M-Q

(global-set-key (kbd "C-c y") 'copy-line)
;; copy line           (una delle tante soluzioni)
(defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive "p")
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;; C-c y

(global-set-key (kbd "C-c C-y") 'duplicate-line)           ;; (like yyp in VI)
;; duplicate line (yyp)
(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)(yank)(open-line 1)(next-line 1)(yank)
)
;; C-c C-y

(global-set-key (kbd "C-c C-i") 'my-insert-file-name)      ;; insert filename at point
;; insert filename at point (as in minibuffer)
;; cfr: https://www.emacswiki.org/emacs/InsertFileName
(defun my-insert-file-name (filename &optional args)
    "Insert name of file FILENAME into buffer after point.

  Prefixed with \\[universal-argument], expand the file name to
  its fully canocalized path.  See `expand-file-name'.

  Prefixed with \\[negative-argument], use relative path to file
  name from current directory, `default-directory'.  See
  `file-relative-name'.

  The default with no prefix is to insert the file name exactly as
  it appears in the minibuffer prompt."
    ;; Based on insert-file in Emacs -- ashawley 20080926
    (interactive "*fInsert file name: \nP")
    (cond ((eq '- args)
           (insert (file-relative-name filename)))
          ((not (null args))
           (insert (expand-file-name filename)))
          (t
           (insert filename))))
;; C-c C-i


;;  ————————————————————  LM owns section   —————————————————————————————————  ;;

(global-set-key (kbd "C-c C-t") 'lm-insert-time-stamp-template) ;; LM own timestamp
;; inserisce la stringa che poi l'hook aggiorna al salvataggio
(defun lm-insert-time-stamp-template ()
  "Insert Time-stamp: <> at beginning of file (8 lines) and comment it according current major mode."
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (insert " Time-stamp: <> \n")
    (goto-char (point-min))
    (let (p1 p2)
    (goto-char (point-min))
    (setq p1 (point))
    (end-of-line)
    (setq p2 (point))
    (comment-region p1 p2))
    ))
;; C-c C-t
;; inserisce un timestamp in cima ai file


;;  —————————————————————————————————————————————————————————————————————————  ;;
;;                  funzioni core LM (senza keybinding!)
;;  —————————————————————————————————————————————————————————————————————————  ;;

(defun dos2unix ()
  "Convert a DOS formatted text buffer to UNIX format"
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix nil))

(defun unix2dos ()
  "Convert a UNIX formatted text buffer to DOS format"
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos nil))

;; swap delle due finestre aperte
;; cfr: https://stackoverflow.com/questions/1774832/how-to-swap-the-buffers-in-2-windows-emacs
(defun swap-buffers-in-windows ()
  "Put the buffer from the selected window in next window, and vice versa"
  (interactive)
  (let* ((this (selected-window))
     (other (next-window))
     (this-buffer (window-buffer this))
     (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)
    )
  )
