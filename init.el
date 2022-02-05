;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;					LM 2022-02-04					;;
;;    Time-stamp: <2022-02-05 15:20:27 ramius>		;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(random t)													;; random first, alea later
(message "Reading cnfgrtn file: resistence is futile.")		;; in minibuffer
(setq user-full-name "Nomone Cognomone")					;; Hi Emacs, I'm mem.device
(tool-bar-mode -1)											;; no tool bar
;;(menu-bar-mode -1)										;; no menu bar
(scroll-bar-mode -1)										;; no scroll bar
(setq inhibit-startup-message t)							;; no startup screen, only scratch buffer
(defalias 'yes-or-no-p 'y-or-n-p)   						;; breviter
(global-set-key (kbd "C-x k") 'kill-current-buffer)			;; chiude il buffer senza fare domande
(setq sentence-end-double-space nil)						;; sentences end with a single space
															;; (this makes sentence navigation work!)

;;  ————————————————————   core keybindings —————————————————————————————————  ;;
;;                     (no lisp function, sorry)                               ;;

(global-set-key (kbd "C-<tab>") 'next-buffer)        		;; TAB is for switching
(global-set-key (kbd "C-S-<tab>") 'previous-buffer)  		;; SHIFT-TAB is for reverse switching
(global-set-key "\C-x\C-b" 'buffer-menu)  					;; C-x C-b puts point on buffer list!
(global-set-key (kbd "C-c C-b") 'eval-buffer)        		;; evaluate buffer (non è definito...?)
(global-set-key "\C-c\C-a" 'mark-whole-buffer)      		;; make C-c C-a “select all”


(define-key global-map (kbd "C-c +") 'text-scale-increase) 	;; C-c + increse font size
(define-key global-map (kbd "C-c -") 'text-scale-decrease) 	;; C-c - decrese font size
(global-set-key (kbd "C-c b") 'ding)       ;; keybinding test: bell!

(global-set-key (kbd "C-c o") 'occur)               		;; M-x occur shortcut
(global-set-key (kbd "C-c r") 'query-replace-regexp) 		;; default C-M-%
(defalias 'qrr 'query-replace-regexp)						;; breviter

(global-set-key (kbd "C-c d") 'kill-whole-line)     		;; kill line - Xah usa
(global-set-key (kbd "C-x k") 'kill-current-buffer) 		;; C-x k kill buffer, no question!
;; NMB : 'current'                  ^^^^^^^					;; cfr. https://www.emacswiki.org/emacs/EmacsCrashCode

;;  ————————————————————     re-enable keys   ———————————————————————————————  ;;

(put 'downcase-region 'disabled nil)      ;; lowercase region with C-x C-l
(put 'upcase-region 'disabled nil)        ;; uppercase region with C-x C-u.

;;  ————————————————————   directory e file —————————————————————————————————  ;;

;; EMACS write config here...
(setq custom-file "~/.emacs.d/custom-file.el")
;;(load-file custom-file)			;; sic
(ignore-errors (load custom-file))	;; sic (it may not yet exist...)

;; ...and put backup files here...
(setq backup-directory-alist '(("" . "~/.backup/emacs")))

;;   ...looks here for personal elisp lib dir (package)...
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; ...and put here the minibuffer history
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)       ;; salvataggio dell'history del minibuffer e find-file tra le sessioni

;; 		configurazione che inceppa lo scroll-all-mode
;;		IL MOTIVO E' IL CUA MODE!!
;; 		forse qui una soluzione?
;; cfr: https://emacs.stackexchange.com/questions/62290/cua-mode-commands-broken-at-launch-until-the-mode-is-manually-toggled


;;  —————————————————————————————————————————————————————————————————————————  ;;


(global-visual-line-mode t)         ;; default word wrap on all your documents
(global-hl-line-mode t)				;; highlight current line
(setq x-stretch-cursor t)			;; block cursor as wide as the glyph under it
(show-paren-mode 1)					;; evidenzia le parentesi a coppie
(electric-pair-mode 1)				;; auto close bracket insertion
(setq column-number-mode t)			;; column number on
(size-indication-mode t)			;; show file size (emacs 22+)
;;(save-place-mode 1) 				;; remember cursor position (emacs 25.1 or later)
(setq-default tab-width 4)			;; reduce to four, default is eight
(setq debug-on-error t)             ;; enter the debugger each time an error is found
(setq view-read-only t)             ;; M-x view-mode (C-c C-q = view-mode)
(setq-default indent-tabs-mode nil)	;; use spaces instead of tabs when indenting
(setq delete-by-moving-to-trash t)  ;; files deleted via Emacs are moved to the Recycle Bin
(setq calendar-week-start-day 1)	;; la settimana inizia di (l)unodì
;;(setq-default major-mode 'text-mode)  						;; set text-mode as default major mode
;;(setq initial-major-mode 'text-mode) ;;force Emacs to start in text mode

;;  —————————————————————————————————————————————————————————————————————————  ;;

(add-hook 'before-save-hook 'delete-trailing-whitespace)	;; ...before saving
(add-hook 'before-save-hook 'time-stamp)					;; aggiorna il time-stamp

;;  —————————————————————————————————————————————————————————————————————————  ;;

(auto-compression-mode 1)           ;; abilita l'apertura di file compressi
									;; and .dict files are UTF-8, so
;;(add-to-list 'file-coding-system-alist '("\\.dict\\'" . utf-8))
;;(setq read-buffer-completion-ignore-case 't) ;; completing ignore case buffer names
;;                                             ;; cfr. https://www.emacswiki.org/emacs/EmacsCrashCode

;;  —————————————————————————————————————————————————————————————————————————  ;;

;;								default: OFF

;;(setq window-min-height 10)		;; Minimal height of windows
;;(setq require-final-newline t)	;;
;;(setq-default fill-column 72)     ;; fill column: 72 (M-q)
;;(setq-default word-wrap t)        ;; visual line mode on
;;(global-linum-mode 1)             ;; show line numbers everywhere
;;(setq case-fold-search t)         ;; make searches case insensitive ;;LM: ma serve ancora?
;;(setq-default indicate-empty-lines t)   		;;show (in left margin) marker for empty lines



;;  ——————————————————  EOL mode line info ——————————————————————————————————  ;;
(setq eol-mnemonic-unix       ":[LF] ")
(setq eol-mnemonic-dos        ":[CRLF] ")
(setq eol-mnemonic-mac        ":[CR] ")
(setq eol-mnemonic-undecided  ": [??] ")
;; NB: mnemonic for utf-8 is "U", which is defined in the mule.el
;; LM: per l'ISO-8859-1 il mnemonico è "1", oltretutto poco leggibile
;;  —————————————————————————————————————————————————————————————————————————  ;;

;; EOL Unix [LF]
(setq-default buffer-file-coding-system 'utf-8-unix)
;; verify with C-h v buffer-file-coding-system.
;; It should say "global value is utf-8-unix".

;;  —————————————————————————————————————————————————————————————————————————  ;;

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))

;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; cfr: https://www.masteringemacs.org/article/working-coding-systems-unicode-emacs
;;  —————————————————————————————————————————————————————————————————————————  ;;


;;  —————————————————————————————————————————————————————————————————————————  ;;
;;						ON [F]UNCTION KEYS!
;;  —————————————————————————————————————————————————————————————————————————  ;;

;; [F1]
;; [F2]
;; [F3]
;; [F4]
(global-set-key [f5] 'reload-dotemacs)		;; [F5] reload emacs dotfile (init.el) 		- (M-x load-file)
(global-set-key [f6] "HelLo woRld!! ")		;; [F6] say HelLo woRld! (LM test function)
;; [F7]
(global-set-key [f8] 'xah-new-empty-buffer)	;; [F8] to open a new empty buffer, without prompting for a name
(global-set-key [f9] 'recentf-open-files)	;; [F9] recentf on: file aperti di recente 	- (M-x recentf-open-files)
;; [F10]	no way! menu
;; [F11]
(global-set-key [f12] 'kill-other-buffers)	;; [F12] to kill all other buffer except current one

;;  —————————————————————————————————————————————————————————————————————————  ;;

;; [F5] reload emacs dotfile (init.el)
(defun reload-dotemacs ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))
;; It would be handy to have a global key binding to reload .emacs
;; rather than go through the incredibly laborious process of
;; M-x load-file (delete a long string if I'm deep into some directory) ~/.emacs <RET>.
;; [F5]

;; [F8] Here's a command to open a new empty buffer, without prompting for a name.
(defun xah-new-empty-buffer ()
  "Create a new empty buffer.
New buffer will be named “untitled” or “untitled<2>”, “untitled<3>”, etc.

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
;; [F8]

;; [F9] recentf on: keep a list of recently opened files
(require 'recentf)
(recentf-mode 1)    ;; LM questo aggiunge il menu in File
(setq recentf-max-saved-items 256)
(setq recentf-max-menu-items 42)
;; [F9]


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
;; C-x C-j          					(default)




;;  —————————————————————————————————————————————————————————————————————————  ;;
;;							T E S T   A R E A
;;  —————————————————————————————————————————————————————————————————————————  ;;
;;  —————————————————————————————————————————————————————————————————————————  ;;


;;	cfr.: https://marcohassan.github.io/bits-of-experience/pages/emacs/

(defun color-highlight ()
  (interactive)
  (set-face-attribute 'region nil :background "indian red" :foreground "grey5"))
(add-hook 'after-init-hook #'color-highlight) ;; to actiavte it when starting emacs.
