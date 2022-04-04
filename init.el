;;;;;;            init.el                                                  ;;;;;;

;; Time-stamp: <2022-03-11 12:40:56 f205200>

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;					LM 2022-02-04 -- 2022-03-07		                           ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(random t)													;; random first, alea later
(tool-bar-mode -1)											;; no tool bar
;;(menu-bar-mode -1)										;; no menu bar
(scroll-bar-mode -1)										;; no scroll bar
(setq inhibit-startup-message t)	                        ;; no startup screen, only scratch buffer
(message "Reading cnfgrtn file: resistence is futile.")		;; in minibuffer

;;  ————————————————————  directory e file  —————————————————————————————————  ;;

;; (ignore-errors (load "~/.emacs.d/boot.el"))       ;; frame appearence at start up here
(ignore-errors (load "~/.emacs.d/lm-data"))          ;; LM private and data
(ignore-errors (load "~/.emacs.d/win32"))            ;; when on windows, do as windowers do
(ignore-errors (load "~/.emacs.d/functions.el"))
;; (ignore-errors (load "~/.emacs.d/keybindings.el"))
(ignore-errors (load "~/.emacs.d/sandbox.el"))    ;; LISP code test here
(add-to-list 'load-path "~/.emacs.d/lisp/")          ;; elisp lib dir (crank package)
(ignore-errors (load "~/.emacs.d/packages.el"))      ;; packages call and config here

;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ;; themes directory (only root dir, no subdirs)
;; aggiungo la directory dei temi alla variabile specifica
;; NB: per aggiungere le subdir guarda qui, in basso:
;; https://www.emacswiki.org/emacs/CustomThemes

(setq custom-file "~/.emacs.d/custom-file.el")
(ignore-errors (load custom-file))	;; sic (it may not yet exist...)
;;  —————————————————————————————————————————————————————————————————————————  ;;
;; ...and put backup files here...
(setq backup-directory-alist `(("." . "~/.backup/emacs"))
      ;; backup-by-copying t
      delete-old-versions t
      kept-new-versions 8
      kept-old-versions 2
      version-control t)
;; (setq backup-directory-alist '(("" . "~/.backup/emacs"))) ;; older, simpler version
;;  —————————————————————————————————————————————————————————————————————————  ;;
;; ...and put here the minibuffer history
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)       ;; salvataggio dell'history del minibuffer e find-file tra le sessioni
;;
;; 	configurazione che inceppa lo scroll-all-mode IL MOTIVO E' IL CUA MODE!!
;;  —————————————————————————————————————————————————————————————————————————  ;;


;;  —————————————————————————————————————————————————————————————————————————  ;;
;;                         core keybindings (cfr. keybinding.el)
;;  —————————————————————————————————————————————————————————————————————————  ;;

;;                     (no new lisp function here!!)                           ;;

;;  ————————————————————   core keybindings —————————————————————————————————  ;;

(global-set-key (kbd "C-<tab>") 'next-buffer)        		;; TAB is for switching
(global-set-key (kbd "C-S-<tab>") 'previous-buffer)  		;; SHIFT-TAB is for reverse
(global-set-key (kbd "C-x k") 'kill-current-buffer)			;; close the buffer, no questions!
;;                                                     ;; cfr. https://www.emacswiki.org/emacs/EmacsCrashCode
(global-set-key (kbd "M-z") 'zap-up-to-char)           ;; swap
(global-set-key (kbd "M-Z") 'zap-to-char)              ;; swap
(global-set-key (kbd "C-s") 'isearch-forward-regexp)   ;; swap
(global-set-key (kbd "C-r") 'isearch-backward-regexp)  ;; swap
(global-set-key (kbd "C-M-s") 'isearch-forward)        ;; swap
(global-set-key (kbd "C-M-r") 'isearch-backward)       ;; swap
;;
(global-set-key (kbd "C-c b") 'ding)                        ;; keybinding test: bell!
;; C-c c
(global-set-key (kbd "C-c d") 'kill-whole-line)     		;; kill line - Xah usa
;; C-c e  - cfr. sotto
;; C-c f  - cfr. sotto
;; C-c n  - cfr. sotto
(global-set-key (kbd "C-c o") 'occur)               		;; M-x occur shortcut
(global-set-key (kbd "C-c r") 'query-replace-regexp) 		;; default C-M-%
(global-set-key (kbd "C-c w") 'visual-line-mode)            ;; activate/deactivate word wrapping
(global-set-key (kbd "C-c z") 'wrong-function)              ;; test for a function that dosen't exist
;;
(define-key global-map (kbd "C-c +") 'text-scale-increase) 	;; C-c + increse font size
(define-key global-map (kbd "C-c -") 'text-scale-decrease) 	;; C-c - decrese font size
(global-set-key (kbd "C-c C-j") 'eval-buffer)        		;; evaluate buffer (non è definito...?)
(global-set-key (kbd "C-c C-a") 'mark-whole-buffer)      	;; make C-c C-a “select all”
;;(global-set-key (kbd "C-x C-b") 'buffer-menu)  	     ;; C-x C-b puts point on buffer list!
(global-set-key (kbd "C-x C-b") 'ibuffer)  		       ;; idem; but now massive regexp substuitutions is possibile on
                                                       ;; *non*  opened files! (i.e. on file not only on emacs buffers)
                                                       ;; ibuffer works as dired
(global-set-key (kbd "M-/") 'hippie-expand)            ;; ??


;;  ———————————————————  quick file shortcut   ——————————————————————————————  ;;

(global-set-key (kbd "C-c n")  ;; N come notes! (C-c o è occupato da 'occur...)
                (lambda () (interactive) (find-file "~/note.org")))

(global-set-key (kbd "C-c c") 'org-capture)
(setq org-default-notes-file "~/organizer.org") ;; qui però definisco l'organizer come collettore

;;(global-set-key (kbd "C-c e")  ;; E come Emacs autobook
;;                (lambda () (interactive) (find-file "~/emacs-XXXX.org")))

(global-set-key (kbd "C-c f")  ;; F come Frittura Totale Globale .-)
                (lambda () (interactive) (find-file "~/F-T-G.org")))

(global-set-key (kbd "C-c z")  ;; Z come Zibalduccio
                (lambda () (interactive) (find-file "~/zibalduccio.org")))

;; Instead of using C-x C-f (find-file) all the time, set up shortcuts to jump
;; to the Org files you use the most. This way, you can easily type that
;; keyboard shortcut, go to the end of the file, and add your note.

;; Here's some sample code that sets the C-c o shortcut to open organizer.org
;; in your home directory. You can add it to your ~/.emacs.d/init.el and then
;; call M-x eval-buffer to load the changes.

;; crf.:https://sachachua.com/blog/2015/02/learn-take-notes-efficiently-org-mode/

;;  ———————————————————————    re-enable keys   —————————————————————————————  ;;
(put 'downcase-region 'disabled nil)      ;; lowercase region with C-x C-l
(put 'upcase-region 'disabled nil)        ;; uppercase region with C-x C-u.

;;  ————————————————————————    aliases           ————————————————————————————  ;;

(defalias 'qrr 'query-replace-regexp)						;; breviter
;;  —————————————————————————————————————————————————————————————————————————  ;;

(defalias 'yes-or-no-p 'y-or-n-p)         ;; breviter
(setq sentence-end-double-space nil)      ;; sentences end with a single space (and s. navigation works!)
(setq-default word-wrap t)        	      ;; visual line mode on
(global-hl-line-mode t)				      ;; highlight current line
(show-paren-mode 1)					      ;; evidenzia le parentesi a coppie
(electric-pair-mode 1)				      ;; auto close bracket insertion
(setq column-number-mode t)			      ;; column number on
(size-indication-mode t)			      ;; show file size (emacs 22+)
(setq debug-on-error t)                   ;; enter the debugger each time an error is found
(setq view-read-only t)                   ;; M-x view-mode (C-c C-q = view-mode)
(setq-default tab-width 4)		          ;; reduce to four, default is eight
(setq-default indent-tabs-mode nil)	      ;; use spaces instead of tabs when indenting
(setq x-stretch-cursor t)			      ;; block cursor as wide as the glyph under it
(setq delete-by-moving-to-trash t)        ;; files deleted via Emacs are moved to the Recycle Bin
(setq calendar-week-start-day 1)	      ;; la settimana inizia di (l)unodì
;;(setq-default major-mode 'text-mode)    ;; set text-mode as default major mode
;;(setq initial-major-mode 'text-mode)    ;; force Emacs to start in text mode
(setq case-fold-search t)                 ;; make searches case insensitive ;;
(ffap-bindings)                           ;; find-file-at-point: smarter C-x C-f (point on path or URL)

;;  ————————————————————————    hooks            ————————————————————————————  ;;

(add-hook 'before-save-hook 'delete-trailing-whitespace)	;; ...before saving, clean file
(add-hook 'before-save-hook 'time-stamp)					;; aggiorna il time-stamp

;;  —————————————————————————————————————————————————————————————————————————  ;;
(auto-compression-mode 1)                 ;; abilita l'apertura di file compressi
;;(add-to-list 'file-coding-system-alist '("\\.dict\\'" . utf-8)) ;; .dict files are UTF-8, so...

(setq read-buffer-completion-ignore-case 't) ;; completing ignore case buffer names
;;                                           ;; cfr. https://www.emacswiki.org/emacs/EmacsCrashCode

;;	———————————————————————————	default: OFF ———————————————————————————————   ;;

;;(setq window-min-height 10)		;; Minimal height of windows
;;(setq require-final-newline t)	;;
(setq-default fill-column 78)       ;; fill column: 78 (M-q)
;;(setq-default word-wrap t)        ;; visual line mode on
;;(global-linum-mode 1)             ;; show line numbers everywhere
;;(setq-default indicate-empty-lines t) ;;show (in left margin) marker for empty lines
;;(save-place-mode 1) 				      ;; remember cursor position (emacs 25.1 or later)
;;  —————————————————————————————————————————————————————————————————————————  ;;

;;  —————————————————————————————————————————————————————————————————————————  ;;

;;                         LM core LIPS packages (cfr. function.el)

;;  —————————————————————————————————————————————————————————————————————————  ;;

;; Common Lisp lib: la libreria di compatibilità
(require 'cl-lib)

;; lorem ipsum etc.
(require 'lorem-ipsum)
(lorem-ipsum-use-default-bindings)
;; C-c l p: lorem-ipsum-insert-paragraphs
;; C-c l s: lorem-ipsum-insert-sentences
;; C-c l l: lorem-ipsum-insert-list

;;  —————————————————————————————————————————————————————————————————————————  ;;
;;								configurazioni								   ;;
;;  —————————————————————————————————————————————————————————————————————————  ;;

;; RET non apre nuovi buffer in dired, ma usa sempre lo stesso buffer,
;; senza accodare le "liste" (come quando si usa i)
(require 'dired )
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
;; was dired-advertised-find-file
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))
;; was dired-up-directory
(put 'dired-find-alternate-file 'disabled nil)
;; cfr: http://ergoemacs.org/emacs/emacs_dired_tips.html

;; In any file buffer, Alt+x dired-jump [Ctrl+x Ctrl+j]
;; to jump to the directory of current buffer.
(require 'dired-x)
;; C-x C-j
;;  —————————————————————————————————————————————————————————————————————————  ;;


;;  ——————————————————  EOL mode line info ——————————————————————————————————  ;;

(setq eol-mnemonic-unix       ":[LF] ")
(setq eol-mnemonic-dos        ":[CRLF] ")
(setq eol-mnemonic-mac        ":[CR] ")
(setq eol-mnemonic-undecided  ": [??] ")
;; NB: mnemonic for utf-8 is "U", which is defined in the mule.el
;; LM: per l'ISO-8859-1 il mnemonico è "1", oltretutto poco leggibile
;;  —————————————————————————————————————————————————————————————————————————  ;;

;; E TRE!!

(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(setq-default buffer-file-coding-system 'utf-8-unix)
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))


;;  —————————————————————————————————————————————————————————————————————————  ;;

;; EOL Unix default
;; (setq-default buffer-file-coding-system 'utf-8-unix) ;; post Emacs 23.2
;; verify with C-h v buffer-file-coding-system.
;; It should say "global value is utf-8-unix".

;;  ——————————————————  UTF-8 configuration —————————————————————————————————  ;;

;; ;; UTF-8 as default encoding
;; ;; cfr: https://marcohassan.github.io/bits-of-experience/pages/emacs/
;; (set-language-environment "utf-8")
;; (prefer-coding-system 'utf-8)
;; (setq coding-system-for-read 'utf-8)
;; (setq coding-system-for-write 'utf-8)

;; alternativa precedente
;; cfr: https://www.masteringemacs.org/article/working-coding-systems-unicode-emacs

;; (prefer-coding-system 'utf-8)
;; (prefer-coding-system 'utf-8-unix) ;; potrebbe essere meglio questa
;; (set-default-coding-systems 'utf-8-unix) ;; e così questa
;; (set-terminal-coding-system 'utf-8)
;; (set-keyboard-coding-system 'utf-8)
;; ;; backwards compatibility as default-buffer-file-coding-system
;; ;; is deprecated in 23.2.
;; (if (boundp 'buffer-file-coding-system)
;;     (setq-default buffer-file-coding-system 'utf-8)
;;   (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
;; (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; cfr.: https://stackoverflow.com/questions/20723229/how-to-reset-emacs-to-save-files-in-utf-8-unix-character-encoding

;;  —————————————————————————————————————————————————————————————————————————  ;;
;;						ON [F]UNCTION KEYS!
;;  —————————————————————————————————————————————————————————————————————————  ;;

(global-set-key [f1] 'other-window)      ;; [F1] switch to oter window
;;(global-set-key [f2] () ;; sync translation windows
;; [F3] ;; start recording macro
;; [F4] ;; stop recording macro / execute last macro
(global-set-key [f5] 'reload-dotemacs)		;; [F5] reload emacs dotfile (init.el) 		- (M-x load-file)
(global-set-key [f6] "HelLo woRld!! ")		;; [F6] say HelLo woRld! (LM test function)
(global-set-key [f7] 'kill-other-buffers)   ;; [F7] kill all buffers except the currento one
(global-set-key [f8] (lambda () (interactive) (find-file "~/note.org"))) ;; NB: shortcut di C-c n - apre il notes.org
(global-set-key [f9] 'recentf-open-files)	;; [F9] recentf on: file aperti di recente 	- (M-x recentf-open-files)
;; [F10]	no way! menu
;; [F11]    full-screen maximize on/off
(global-set-key [f12] 'xah-new-empty-buffer)	;; [F12] to open a new empty buffer, without prompting for a name

;;  —————————————————————————————————————————————————————————————————————————  ;;

;; [F5] reload emacs dotfile (init.el)
(defun reload-dotemacs ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))
;; It would be handy to have a global key binding to reload .emacs
;; rather than go through the incredibly laborious process of
;; M-x load-file (delete a long string if I'm deep into some directory) ~/.emacs <RET>.
;; [F5]


;; [F7] Kill Other Buffers --- here is a simple function that kills all buffers, except the current one.
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))
;; [F7]


;; [F9] recentf on: keep a list of recently opened files
(require 'recentf)
(recentf-mode 1)    ;; LM questo aggiunge il menu in File
(setq recentf-max-saved-items 256)
(setq recentf-max-menu-items 42)
;; [F9]

;; [F12] Here's a command to open a new empty buffer, without prompting for a name.
(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
New buffer will be named “fourtytwo” or “fourtytwo<2>”, “fourtytwo<3>”, etc.

It returns the buffer (for elisp programing).

URL `http://ergoemacs.org/emacs/emacs_new_empty_buffer.html'
Version 2017-11-01"
  (interactive)
  (let (($buf (generate-new-buffer "fourtytwo")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf
    ))
;; [F12]

;;  —————————————————————————————————————————————————————————————————————————  ;;


;;                                    CUI                                      ;;


;;  —————————————————————————————————————————————————————————————————————————  ;;
;;                      titolo del frame (SO windows)
;;  —————————————————————————————————————————————————————————————————————————  ;;
(setq frame-title-format '(
    "        ⚪ ⚫                                                                      core LM emacs")) ;; Titolo!

;;	cfr.: https://marcohassan.github.io/bits-of-experience/pages/emacs/

;;  —————————————————————————————————————————————————————————————————————————  ;;
;;                   impostazione dei buffer iniziali
;;  —————————————————————————————————————————————————————————————————————————  ;;

(switch-to-buffer (generate-new-buffer "*42*"))
;; con asterischi perché buffer non associato a file; viceversa, viceversa
;; NB: aperto in Fundamentl mode
(with-current-buffer "*42*" (insert ";;  ————————————————————————————————————————————————————————————————————————— ;;
\n            [DUMP HERE]  —  BTW: The answer is: 42!   \n
;;  ————————————————————————————————————————————————————————————————————————— ;;\n\n"))

(switch-to-buffer "*scratch*")

;;  —————————————————————————————————————————————————————————————————————————  ;;


;;  —————————————————————————————————————————————————————————————————————————  ;;
;;                   		colori a manovella
;;  —————————————————————————————————————————————————————————————————————————  ;;

;;(set-face-attribute 'cursor nil :background "DodgerBlue4")  ;; cursor color
;;(set-cursor-color "orange")        ;; cursor color
;;(set-cursor-color "indian red")  ;; cursor color
(set-cursor-color "DodgerBlue4") ;; cursor color

;; (defun color-highlight ()
;;    (interactive)
;;    (set-face-attribute 'region nil :background "DodgerBlue4" :foreground "#004080"))
;; (add-hook 'after-init-hook #'color-highlight) ;; to actiavte it when starting emacs.

;;(set-face-background 'hl-line "#bcd2ee")   ;; light steel blue

;; (set-face-attribute 'region nil :background "#fff8dc" :foreground "#000000")
;; un colore di carta Moleskine

;; (set-face-attribute 'region nil :background "#fffff" :foreground "#004080")

;;  —————————————————————————————————————————————————————————————————————————  ;;


;;  —————————————————————————————————————————————————————————————————————————  ;;
;;							T E S T   A R E A
;;  —————————————————————————————————————————————————————————————————————————  ;;
