;;;;;;            function.el                                              ;;;;;;

;; Time-stamp: <2022-03-30 17:07:57 f205200>

;;;;;;            function.el                                              ;;;;;;

;;  —————————————————————————————————————————————————————————————————————————  ;;

;;  —————————————————————————————————————————————————————————————————————————  ;;

(global-set-key (kbd "C-c i d") 'mp-insert-date)
(global-set-key (kbd "C-c i o") 'mp-insert-ordinal-date)
(global-set-key (kbd "C-c i t") 'mp-insert-time)
;(global-set-key (kbd "C-c i u") cfr. sotto)

;; inserire al volo data e orario
;; from: https://www.masteringemacs.org/article/mastering-key-bindings-emacs
;; cfr: http://ergoemacs.org/emacs/elisp_datetime.html
;;
;; C-c i d — date ISO format   (2021-02-19)
;; C-c i o — odinal data       (2021-050)
;; C-c i t — time              (14:58:25 +0100)
;; C-c i u — UNIX time         (1613743116)

;; C-c i u — insert seconds since the Epoch: UNIX time (1613743116)
(global-set-key (kbd "C-c i u")
                '(lambda ()
                   (interactive)
                   (insert (format-time-string "%s"))))

(defun mp-insert-date ()
  (interactive)
  (insert (format-time-string "%F")))

(defun mp-insert-ordinal-date ()
  (interactive)
  (insert (format-time-string "%Y-%j")))

(defun mp-insert-time ()
  (interactive)
  (insert (format-time-string "%T %z")))

;; C-c i d/o/t/u


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
;; inserisce il template per un timestamp in cima ai file (aggiornato da un hook)


;;  —————————————————————————————————————————————————————————————————————————  ;;
;;  —————————————————————————————————————————————————————————————————————————  ;;

(define-key global-map (kbd "C-c q") 'enlightenment-for-today)

;;;;  RandomThingFromAFile

;; This is a quick piece of emacs lisp that will spit out a random line for a file.

;; This is good for fortune cookies, I Ching readings, Tips of the day, Daily Affirmations, etc.

(defun enlightenment-for-today ()
    (interactive)
    (let* ((thing (random-thing-from-a-file "~/.random-lines.txt")))
	   (message
	    (concat "Random line.\n"
		    ";;  —————————————————————————————————————————————————————————————————————————  ;;\n"
		    thing))))
(defun random-thing-from-a-file (f)
    (interactive "fLoad Thing from: ")
    (random t)
    (save-excursion
     (find-file f)
     (let ((line-num (random (count-lines (point-min) (point-max)))))
       (goto-line line-num)
       (let ((result (buffer-substring (line-beginning-position) (line-end-position))))
         (kill-buffer (current-buffer))
	 result))))

;; cfr.: https://www.emacswiki.org/emacs/RandomThingFromAFile

;;  —————————————————————————————————————————————————————————————————————————  ;;
;;                  from init.el - SMISTA!
;;  —————————————————————————————————————————————————————————————————————————  ;;

(define-key global-map (kbd "M-Q") 'fill-paragraph)     ;; SWAPS
(define-key global-map (kbd "M-q") 'unfill-paragraph)   ;; SWAPS

;; Stefan Monnier <foo at acm.org>. It is the opposite of fill-paragraph
(defun unfill-paragraph (&optional region)
  "Takes a multi-line paragraph and makes it into a single line of text."
  (interactive (progn (barf-if-buffer-read-only) '(t)))
  (let ((fill-column (point-max))
        ;; This would override `fill-column' if it's an integer.
        (emacs-lisp-docstring-fill-column t))
    (fill-paragraph nil region)))
;; M-Q


;;  ———————————————  LM editing: line/par  ———————————————————————————————  ;;

;; init.el (global-set-key (kbd "C-c d") 'kill-whole-line)     		;; kill line
(global-set-key (kbd "C-c y") 'copy-line)  ;; copy line (una delle tante soluzioni)
(global-set-key (kbd "C-c C-y") 'duplicate-line) ;; duplicate line (yyp)

(defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive "p")
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;; C-c y

(defun duplicate-line()
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)(yank)(open-line 1)(next-line 1)(yank)
)
;; C-c C-y

;;  —————————————————————————————————————————————————————————————————————————  ;;

;;  ———————————————  LM editing: insert text  ———————————————————————————————  ;;

;;  —————————————————————————————————————————————————————————————————————————  ;;

(global-set-key (kbd "C-c C-i") 'my-insert-file-name) ;; insert filename at point

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


;;  ————————————————————  Xah Lee section   —————————————————————————————————  ;;

;;  —————————————————————————————————————————————————————————————————————————  ;;

(global-set-key (kbd "C-c r n") 'xah-insert-random-number)
(global-set-key (kbd "C-c r s") 'xah-insert-random-string)
(global-set-key (kbd "C-c r h") 'xah-insert-random-hex)
;; va capito se invece è meglio contrarre in C-c i n/s/h
(global-set-key (kbd "C-c i r n") 'xah-insert-random-number)
(global-set-key (kbd "C-c i r s") 'xah-insert-random-string)
(global-set-key (kbd "C-c i r h") 'xah-insert-random-hex)

;; by XAH insert random string(16), num (8), hexadecimal (12)

;; Insert Random Hexadecimal
(defun xah-insert-random-hex (NUM)
  "Insert NUM random hexadecimal digits.
NUM default to 12.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2017-08-03"
  (interactive "P")
  (let (($n (if (numberp NUM) (abs NUM) 12 )))
    (insert (format  (concat "%0" (number-to-string $n) "x" ) (random (1- (expt 16 $n)))))))

;; Insert Random String
(defun xah-insert-random-string (NUM)
  "Insert a random alphanumerics string of length 16.
The possible chars are: A to Z, a to z, 0 to 9.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2018-08-03"
  (interactive "P")
  (let* (($charset "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
         ($baseCount (length $charset)))
    (dotimes (_ (if (numberp NUM) (abs NUM) 16))
      (insert (elt $charset (random $baseCount))))))

;; Insert Random Number
(defun xah-insert-random-number (NUM)
  "Insert NUM random digits.
NUM default to 5.
Call `universal-argument' before for different count.
URL `http://ergoemacs.org/emacs/elisp_insert_random_number_string.html'
Version 2017-05-24"
  (interactive "P")
  (let (($charset "1234567890" )
        ($baseCount 10))
    (dotimes (_ (if (numberp NUM) (abs NUM) 5 ))
      (insert (elt $charset (random $baseCount))))))

;; C-c i r n/s/h

;;  —————————————————————————————————————————————————————————————————————————  ;;

(global-set-key (kbd "C-c C-w y") #'er-youtube)  ;; Y for YouTube
(global-set-key (kbd "C-c C-w g") #'er-google)   ;; G for Google

;; C-c C-w y -- www.youtube.com
;; C-c C-w g -- www.google.com
;;
;; SEARCH : Google!
;; cfr. https://emacsredux.com/blog/2013/03/28/google/
(defun er-google ()
  "Google the selected region if any, display a query prompt otherwise."
  (interactive)
  (browse-url
   (concat
    "http://www.google.com/search?ie=utf-8&oe=utf-8&q="
    (url-hexify-string (if mark-active
         (buffer-substring (region-beginning) (region-end))
         (read-string "Google: "))))))


;; SEARCH : YouTube!
;; cfr. idem
(defun er-youtube ()
  "Search YouTube with a query or region if any."
  (interactive)
  (browse-url
   (concat
    "http://www.youtube.com/results?search_query="
    (url-hexify-string (if mark-active
                         (buffer-substring (region-beginning) (region-end))
                         (read-string "Search YouTube: "))))))

(global-set-key (kbd "C-c C-w y") #'er-youtube)  ;; Y for YouTube
(global-set-key (kbd "C-c C-w g") #'er-google)   ;; G for Google

;;  —————————————————————————————————————————————————————————————————————————  ;;
;;                  funzioni core LM (senza keybinding!)
;;  —————————————————————————————————————————————————————————————————————————  ;;

;; Xah Lee
;; Show kill-ring — a command that shows all kill-ring content in a new buffer.

(defun xah-show-kill-ring ()
  "Insert all `kill-ring' content in a new buffer named *copy history*.

URL `http://ergoemacs.org/emacs/emacs_show_kill_ring.html'
Version 2019-12-02"
  (interactive)
  (let (($buf (generate-new-buffer "*copy history*")))
    (progn
      (switch-to-buffer $buf)
      (funcall 'fundamental-mode)
      (dolist (x kill-ring )
        (insert x "\n\nLM=============================================================================\n\n"))
      (goto-char (point-min)))))


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
;;  —————————————————————————————————————————————————————————————————————————  ;;
;;  —————————————————————————————————————————————————————————————————————————  ;;
;;  —————————————————————————————————————————————————————————————————————————  ;;
