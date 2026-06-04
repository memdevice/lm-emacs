;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                       LM functions                                          ;;
;;         funzioni custom accumulate nel tempo (non indispensabili)           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  ————————————————————  insert: data e ora  ——————————————————————————————  ;;
;; famiglia C-c i (insert)
;; C-c i d — data ISO format   (2021-02-19)
;; C-c i o — data ordinale     (2021-050)
;; C-c i t — ora               (14:58:25 +0100)
;; C-c i u — UNIX time         (1613743116)
;; cfr: https://www.masteringemacs.org/article/mastering-key-bindings-emacs
;; cfr: http://ergoemacs.org/emacs/elisp_datetime.html
(global-set-key (kbd "C-c i d") 'mp-insert-date)
(global-set-key (kbd "C-c i o") 'mp-insert-ordinal-date)
(global-set-key (kbd "C-c i t") 'mp-insert-time)
(global-set-key (kbd "C-c i u")
                '(lambda ()
                   (interactive)
                   (insert (format-time-string "%s"))))

(defun mp-insert-date ()
  (interactive)
  (insert (format-time-string "%F")))
;; C-c i d

(defun mp-insert-ordinal-date ()
  (interactive)
  (insert (format-time-string "%Y-%j")))
;; C-c i o

(defun mp-insert-time ()
  (interactive)
  (insert (format-time-string "%T %z")))
;; C-c i t

;;  ————————————————————  LM: timestamp template  ——————————————————————————  ;;
(global-set-key (kbd "C-c C-t") 'lm-insert-time-stamp-template)
;; inserisce la stringa che poi l'hook aggiorna al salvataggio
(defun lm-insert-time-stamp-template ()
  "Insert Time-stamp: <> at beginning of file and comment it according to current major mode."
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
      (comment-region p1 p2))))
;; C-c C-t

;;  ————————————————————  enlightenment  ———————————————————————————————————  ;;
;; estrae una riga casuale da un file di testo
;; cfr.: https://www.emacswiki.org/emacs/RandomThingFromAFile
(global-set-key (kbd "C-c q") 'enlightenment-for-today)

(defun enlightenment-for-today ()
  (interactive)
  (let* ((thing (random-thing-from-a-file "~/.random-lines.txt")))
    (message
     (concat "Random line.\n"
             ";;  ——————————————————————————————————————————————  ;;\n"
             thing))))

(defun random-thing-from-a-file (f)
  (interactive "fLoad Thing from: ")
  (random t)
  (save-excursion
    (find-file f)
    (let ((line-num (random (count-lines (point-min) (point-max)))))
      ;; goto-line è deprecata in Emacs 29+, sostituita con forward-line
      ;; (goto-line line-num)
      (goto-char (point-min))
      (forward-line line-num)  ;; forward-line è il modo corretto in Emacs moderno
      (let ((result (buffer-substring (line-beginning-position) (line-end-position))))
        (kill-buffer (current-buffer))
        result))))
;; C-c q

;;  ————————————————————  unfill-paragraph  ————————————————————————————————  ;;
;; Stefan Monnier: opposto di fill-paragraph (unisce le righe di un paragrafo)
(define-key global-map (kbd "M-Q") 'fill-paragraph)    ;; SWAP
(define-key global-map (kbd "M-q") 'unfill-paragraph)  ;; SWAP

(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))
;; M-q / M-Q

;;  ————————————————————  copy/duplicate line  —————————————————————————————  ;;
(global-set-key (kbd "C-c y")   'copy-line)
(global-set-key (kbd "C-c C-y") 'duplicate-line)

(defun copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring."
  (interactive "p")
  (kill-ring-save (line-beginning-position)
                  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;; C-c y

(defun duplicate-line ()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (open-line 1)
  (next-line 1)
  (yank))
;; C-c C-y

;;  ————————————————————  smart open line (VI: o / O)  —————————————————————  ;;
;; cfr. https://emacsredux.com/blog/2013/06/15/open-line-above/
;; cfr. https://emacsredux.com/blog/2013/03/26/smarter-open-line/
(global-set-key (kbd "M-o") 'smart-open-line)
(global-set-key (kbd "M-O") 'smart-open-line-above)
(global-set-key [(shift return)] 'smart-open-line)
(global-set-key [(control shift return)] #'smart-open-line-above)

(defun smart-open-line ()
  "Insert an empty line after the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-end-of-line nil)
  (newline-and-indent))
;; M-o / Shift-Return

(defun smart-open-line-above ()
  "Insert an empty line above the current line.
Position the cursor at its beginning, according to the current mode."
  (interactive)
  (move-beginning-of-line nil)
  (newline-and-indent)
  (forward-line -1)
  (indent-according-to-mode))
;; M-O / Ctrl-Shift-Return

;;  ————————————————————  insert: file name  ———————————————————————————————  ;;
(global-set-key (kbd "C-c C-f") 'my-insert-file-name)
;; cfr: https://www.emacswiki.org/emacs/InsertFileName
(defun my-insert-file-name (filename &optional args)
  "Insert name of file FILENAME into buffer after point.
Prefixed with \\[universal-argument], expand the file name to its fully
canonicalized path.  See `expand-file-name'.
Prefixed with \\[negative-argument], use relative path to file name from
current directory, `default-directory'.  See `file-relative-name'.
The default with no prefix is to insert the file name exactly as
it appears in the minibuffer prompt."
  (interactive "*fInsert file name: \nP")
  (cond ((eq '- args)
         (insert (file-relative-name filename)))
        ((not (null args))
         (insert (expand-file-name filename)))
        (t
         (insert filename))))
;; C-c C-f

;;  ————————————————————  insert: LM glossa  ———————————————————————————————  ;;
;; inserisce '[LM:   ]' e posiziona il cursore dentro le parentesi
(defun my-insert-lm-glossa ()
  "Inserisce '[LM:   ]' e sposta il cursore indietro di un carattere."
  (interactive)
  (insert "[LM:   ]")
  (backward-char 3))
(global-set-key (kbd "C-c C-n") 'my-insert-lm-glossa)
;; C-c C-n

;;  ————————————————————  insert: random (Xah Lee)  ————————————————————————  ;;
;; famiglia C-c i r (insert random)
;; C-c i r n — numero casuale (5 cifre default)
;; C-c i r s — stringa alfanumerica casuale (16 caratteri default)
;; C-c i r h — stringa esadecimale casuale (12 caratteri default)
;; cfr: http://ergoemacs.org/emacs/elisp_insert_random_number_string.html
;; (global-set-key (kbd "C-c r n") 'xah-insert-random-number)  ;; sostituito da C-c i r
;; (global-set-key (kbd "C-c r s") 'xah-insert-random-string)  ;; sostituito da C-c i r
;; (global-set-key (kbd "C-c r h") 'xah-insert-random-hex)     ;; sostituito da C-c i r
(global-set-key (kbd "C-c i r n") 'xah-insert-random-number)
(global-set-key (kbd "C-c i r s") 'xah-insert-random-string)
(global-set-key (kbd "C-c i r h") 'xah-insert-random-hex)

(defun xah-insert-random-hex (NUM)
  "Insert NUM random hexadecimal digits. NUM default to 12.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2017-08-03"
  (interactive "P")
  (let (($n (if (numberp NUM) (abs NUM) 12)))
    (insert (format (concat "%0" (number-to-string $n) "x")
                    (random (1- (expt 16 $n)))))))
;; C-c i r h

(defun xah-insert-random-string (NUM)
  "Insert a random alphanumeric string of length 16.
The possible chars are: A to Z, a to z, 0 to 9.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2018-08-03"
  (interactive "P")
  (let* (($charset "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
         ($baseCount (length $charset)))
    (dotimes (_ (if (numberp NUM) (abs NUM) 16))
      (insert (elt $charset (random $baseCount))))))
;; C-c i r s

(defun xah-insert-random-number (NUM)
  "Insert NUM random digits. NUM default to 5.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2017-05-24"
  (interactive "P")
  (let (($charset "1234567890")
        ($baseCount 10))
    (dotimes (_ (if (numberp NUM) (abs NUM) 5))
      (insert (elt $charset (random $baseCount))))))
;; C-c i r n

;;  ————————————————————  web search  ——————————————————————————————————————  ;;
;; C-c C-w g — Google
;; C-c C-w y — YouTube
;; cfr. https://emacsredux.com/blog/2013/03/28/google/
(global-set-key (kbd "C-c C-w g") #'er-google)
(global-set-key (kbd "C-c C-w y") #'er-youtube)

(defun er-google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                         (read-string "Google: "))))))
;; C-c C-w g

(defun er-youtube ()
  "Search YouTube with a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.youtube.com/results?search_query="
    (url-hexify-string (if mark-active
                           (buffer-substring (region-beginning) (region-end))
                         (read-string "Search YouTube: "))))))
;; C-c C-w y

;;  ————————————————————  utility (senza keybinding)  —————————————————————  ;;

(defun xah-show-kill-ring ()
  "Insert all `kill-ring' content in a new buffer named *copy history*.
URL `http://ergoemacs.org/emacs/emacs_show_kill_ring.html'
Version 2019-12-02"
  (interactive)
  (let (($buf (generate-new-buffer "*copy history*")))
    (switch-to-buffer $buf)
    (funcall 'fundamental-mode)
    (dolist (x kill-ring)
      (insert x "\n\nLM=====================================================================LM\n\n"))
    (goto-char (point-min))))

(defun dos2unix ()
  "Convert a DOS formatted text buffer to UNIX format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix nil))

(defun unix2dos ()
  "Convert a UNIX formatted text buffer to DOS format."
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos nil))

(defun swap-buffers-in-windows ()
  "Put the buffer from the selected window in next window, and vice versa.
cfr: https://stackoverflow.com/questions/1774832"
  (interactive)
  (let* ((this (selected-window))
         (other (next-window))
         (this-buffer (window-buffer this))
         (other-buffer (window-buffer other)))
    (set-window-buffer other this-buffer)
    (set-window-buffer this other-buffer)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          end of functions.el                                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
