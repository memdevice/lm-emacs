;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         LM boot configuration                               ;;
;;         aspetto visivo, tema, font, cursore, posizione finestra             ;;
;;         caricato per ultimo in init.el                                      ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  ————————————————————  tema  ————————————————————————————————————————————  ;;
(load-theme 'leuven t)                        ;; tema leuven (built-in Emacs 30)

;;  ————————————————————  font  ————————————————————————————————————————————  ;;
(set-face-attribute 'default nil
                    :family "Consolas"        ;; font Consolas
                    :height 110)              ;; 11pt (height = pt * 10)

(when (eq system-type 'gnu/linux)
  ;; Default font
  (set-face-attribute 'default nil
    :family "Monospace"
    :height 130)

  ;; ------------------------------------------------------------
  ;; Font preview — scratch buffer use only
  ;; Eval one at a time with C-x C-e to preview each font
  ;; ------------------------------------------------------------
  ;; (set-face-attribute 'default nil :family "Iosevka"                     :height 120)
  ;; (set-face-attribute 'default nil :family "JetBrains Mono"              :height 120)
  ;; (set-face-attribute 'default nil :family "Hack"                        :height 120)
  ;; (set-face-attribute 'default nil :family "Inconsolata"                 :height 120)
  ;; (set-face-attribute 'default nil :family "Atkinson Hyperlegible Mono"  :height 120)
  ;; (set-face-attribute 'default nil :family "Input Mono"                  :height 120)
  ;; Reset to default
  ;; (set-face-attribute 'default nil :family "Monospace" :height 130)
  ) ;; end gnu/linux

;;  ————————————————————  cursore  —————————————————————————————————————————  ;;
;; (set-cursor-color "orange")                ;; cursore arancione
(set-cursor-color "coral")                    ;; cursore corallo

;;  ————————————————————  colori  ——————————————————————————————————————————  ;;
;; (set-face-foreground 'font-lock-comment-face "steel blue")      ;; commenti: ref
;; (set-face-foreground 'font-lock-comment-face "snow4")           ;; commenti: ref
(set-face-foreground 'font-lock-comment-face "light slate gray")   ;; commenti: attivo
;; (set-face-attribute 'region nil :background "wheat1")             ;; sfondo selezione: ref
(set-face-attribute 'region nil :background "light goldenrod yellow") ;; sfondo selezione: attivo
;; (set-face-background 'hl-line "SystemInfoWindow")               ;; riga corrente: ref
(set-face-background 'hl-line "SystemGradientInactiveTitle")       ;; riga corrente: attivo

;;  ————————————————————  posizione finestra  ——————————————————————————————  ;;
;; Linux: TODO
(when (eq system-type 'windows-nt)            ;; Windows: 2560x1440
  (set-frame-parameter nil 'left       1414)   ;; posizione X calibrata
  (set-frame-parameter nil 'top        0)      ;; parte dall'alto
  (set-frame-parameter nil 'width      82)     ;; 82 colonne (righe separazione = 80 char)
  (set-frame-parameter nil 'fullscreen 'fullheight)) ;; altezza automatica (esclude taskbar)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                              end of boot.el                                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
