;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          LM core configuration                              ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  ————————————————————  startup  —————————————————————————————————————————  ;;
(random t)                                   ;; random seed init
(tool-bar-mode -1)                           ;; no tool bar
;;(menu-bar-mode -1)                         ;; no menu bar
(scroll-bar-mode -1)                         ;; no scroll bar
(setq inhibit-startup-message t)             ;; no startup screen
(setq inhibit-startup-echo-area-message t)
(setq message-log-max nil)                   ;; disabilita il log nel *Messages* buffer
(kill-buffer "*Messages*")                   ;; commenta queste due righe se vuoi il log
(message "Reading cnfgrtn file - resistence is futile.")

;;  ————————————————————  path e file di sistema  ——————————————————————————  ;;
(setq custom-file "~/.emacs.d/custom-file.el")
(ignore-errors (load custom-file))           ;; potrebbe non esistere ancora

(add-to-list 'load-path "~/.emacs.d/lisp/") ;; package artigianali e codice lisp locale

(setq backup-directory-alist `(("." . "~/.backup/emacs"))
      delete-old-versions t
      kept-new-versions 8
      kept-old-versions 2
      version-control t)

(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)                            ;; salva history minibuffer tra le sessioni

;;  ————————————————————  settings generali  ———————————————————————————————  ;;
(setq sentence-end-double-space nil)         ;; le frasi finiscono con uno spazio solo
(setq-default word-wrap t)                   ;; visual line mode on
(setq-default fill-column 78)               ;; fill column: 78 (M-q)
(setq-default tab-width 4)                  ;; tab = 4 spazi
(setq-default indent-tabs-mode nil)         ;; usa spazi invece di tab
(setq case-fold-search t)                   ;; ricerca case insensitive
(setq x-stretch-cursor t)                   ;; cursore largo come il glifo sottostante
(setq delete-by-moving-to-trash t)          ;; file eliminati vanno nel cestino
(setq calendar-week-start-day 1)            ;; la settimana inizia di lunedì
(setq view-read-only t)                     ;; apre file read-only in view-mode
;;(setq debug-on-error t)                   ;; entra nel debugger ad ogni errore - trasferito in sandbox.el

(global-hl-line-mode t)                     ;; evidenzia la riga corrente
(show-paren-mode 1)                         ;; evidenzia le parentesi a coppie
(electric-pair-mode 1)                      ;; chiusura automatica parentesi/virgolette
(column-number-mode t)                      ;; numero di colonna in mode line
(size-indication-mode t)                    ;; dimensione file in mode line
(auto-compression-mode 1)                   ;; apre file compressi

(setq read-buffer-completion-ignore-case t) ;; completion buffer names case insensitive
(ffap-bindings)                             ;; C-x C-f diventa smart (path e URL)

(define-key global-map (kbd "RET") 'newline-and-indent) ;; RET indenta automaticamente

;;  ————————————————————  hooks  ———————————————————————————————————————————  ;;
(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; pulizia prima del salvataggio
(add-hook 'before-save-hook 'time-stamp)                 ;; aggiorna il time-stamp

;;  ————————————————————  UTF-8  ———————————————————————————————————————————  ;;
(prefer-coding-system 'utf-8-unix)
(set-default-coding-systems 'utf-8-unix)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;;  ————————————————————  EOL mode line  ———————————————————————————————————  ;;
(setq eol-mnemonic-unix      ":[LF] ")
(setq eol-mnemonic-dos       ":[CRLF] ")
(setq eol-mnemonic-mac       ":[CR] ")
(setq eol-mnemonic-undecided ":[??] ")

;;  ————————————————————  aliases  —————————————————————————————————————————  ;;
(defalias 'qrr 'query-replace-regexp)
(defalias 'yes-or-no-p 'y-or-n-p)

;;  ————————————————————  recentf  ————————————————————————————————————————  ;;
;; built-in: lista dei file aperti di recente
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 256)
(setq recentf-max-menu-items  42)
;; [F9] recentf-open-files  (keybinding definito sotto)

;;  ————————————————————  tasti funzione  ——————————————————————————————————  ;;
(global-set-key [f1]  'delete-other-windows)  ;; [F1] delete-other-windows (C-x 1)
(global-set-key [f2]  'switch-to-minibuffer)  ;; [F2] focus al minibuffer
;; [F3]                                        ;; [F3] start recording macro
;; [F4]                                        ;; [F4] stop recording / execute macro
(global-set-key [f5]  'reload-dotemacs)       ;; [F5] reload init.el
(global-set-key [f6]  'xah-new-empty-buffer)  ;; [F6] nuovo buffer vuoto
(global-set-key [f7]  'kill-other-buffers)    ;; [F7] kill tutti i buffer tranne il corrente
(global-set-key [f8]  'repeat)                ;; [F8] repeat last command (alias C-x z)
(global-set-key [f9]  'recentf-open-files)    ;; [F9] file aperti di recente
;; [F10]                                       ;; [F10] menu (riservato)
;; [F11]                                       ;; [F11] fullscreen (riservato)
(global-set-key [f12] 'other-window)          ;; [F12] switch to other window (C-x o)
(global-set-key [f13] "HelLo woRld!! ")       ;; [F13] test

;;  ————————————————————  funzioni core  ———————————————————————————————————  ;;

;; [F2] switch-to-minibuffer
(defun switch-to-minibuffer ()
  "Switch to minibuffer window."
  (interactive)
  (if (active-minibuffer-window)
      (select-window (active-minibuffer-window))
    (error "Minibuffer is not active")))

;; [F5] reload init.el
(defun reload-dotemacs ()
  (interactive)
  (load-file "~/.emacs.d/init.el"))

;; [F6] nuovo buffer vuoto
(defun xah-new-empty-buffer ()
  "Crea un nuovo buffer vuoto chiamato fourtytwo, fourtytwo<2> ecc."
  (interactive)
  (let (($buf (generate-new-buffer "fourtytwo")))
    (switch-to-buffer $buf)
    (funcall initial-major-mode)
    (setq buffer-offer-save t)
    $buf))

;; [F7] kill all buffers except current
(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

;;  ————————————————————  keybindings core  ————————————————————————————————  ;;

;;  — navigazione buffer —
(global-set-key (kbd "C-<tab>")   'next-buffer)
(global-set-key (kbd "C-S-<tab>") 'previous-buffer)
(global-set-key (kbd "C-x k")     'kill-current-buffer)
(global-set-key (kbd "C-x C-b")   'ibuffer)
(global-set-key (kbd "C-c B")     'bury-buffer)

;;  — editing —
;; (global-set-key (kbd "C-c x") #'exchange-point-and-mark)  ;; TODO: non funziona correttamente, da risolvere
(global-set-key (kbd "M-z")   'zap-up-to-char)
(global-set-key (kbd "M-Z")   'zap-to-char)
(global-set-key (kbd "C-c d") 'kill-whole-line)
(global-set-key (kbd "C-c j") 'join-line)
(define-key global-map (kbd "C-c +") 'text-scale-increase)
(define-key global-map (kbd "C-c -") 'text-scale-decrease)

;;  — ricerca —
(global-set-key (kbd "C-s")   'isearch-forward-regexp)
(global-set-key (kbd "C-r")   'isearch-backward-regexp)
(global-set-key (kbd "C-M-s") 'isearch-forward)
(global-set-key (kbd "C-M-r") 'isearch-backward)
(global-set-key (kbd "C-c o") 'occur)
(global-set-key (kbd "C-c r") 'query-replace-regexp)

;;  — org e file rapidi (TODO: spostare in file note dedicato) —
(global-set-key (kbd "C-c c") 'org-capture)
(global-set-key (kbd "C-c n") (lambda () (interactive) (find-file "~/note.org")))
(global-set-key (kbd "C-c f") (lambda () (interactive) (find-file "~/F-T-G.org")))
(global-set-key (kbd "C-c z") (lambda () (interactive) (find-file "~/zibalduccio.org")))
(setq org-default-notes-file "~/organizer.org")

;;  — misc —
(global-set-key (kbd "C-c b")   'ding)
(global-set-key (kbd "C-c C-j") 'eval-buffer)
(global-set-key (kbd "C-c v")   'visual-line-mode)
(put 'downcase-region 'disabled nil)
(put 'upcase-region   'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              end of core.el                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
