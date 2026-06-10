;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                     LM ui-modern configuration                              ;;
;;           vertico · orderless · marginalia · consult                        ;;
;;           cfr.: https://github.com/minad/vertico                            ;;
;;                 https://github.com/oantolin/orderless                       ;;
;;                 https://github.com/minad/marginalia                         ;;
;;                 https://github.com/minad/consult                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  ————————————————————  vertico  —————————————————————————————————————————  ;;
;; completion verticale nel minibuffer: sostituisce il default orizzontale
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

;;  ————————————————————  orderless  ———————————————————————————————————————  ;;
;; matching flessibile: le parole del pattern vengono cercate in qualsiasi ordine
;; es.: "find buf" trova "find-buffer" ma anche "buffer-find"
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
;; NB: basic e partial-completion come fallback per i path di file

;;  ————————————————————  marginalia  ——————————————————————————————————————  ;;
;; aggiunge annotazioni (docstring, path, keybinding...) nei completion buffers
(use-package marginalia
  :ensure t
  :init
  (marginalia-mode 1))
(keymap-set minibuffer-local-map "M-A" #'marginalia-cycle)   ;; LM: cicla tra i tipi di annotazione

;;  ————————————————————  consult  —————————————————————————————————————————  ;;
;; comandi arricchiti che si integrano con vertico:
;; consult-buffer, consult-line, consult-grep, consult-find ecc.
(use-package consult
  :ensure t
  :bind
  (("C-x b"   . consult-buffer)          ;; switch buffer arricchito
   ("C-x 4 b" . consult-buffer-other-window)
   ("M-y"     . consult-yank-pop)        ;; kill ring navigabile
   ("M-s l"   . consult-line)            ;; ricerca riga nel buffer (come occur)
   ("M-s g"   . consult-grep)            ;; grep arricchito
   ("M-s G"   . consult-git-grep)))      ;; grep su git repo

;;  ————————————————————  corfu  ———————————————————————————————————————————  ;;
;; completion inline nel buffer (mentre si scrive)
;; NB: più invasivo degli altri, richiede tuning - attivare dopo aver
;;     preso confidenza con lo stack vertico/orderless/marginalia/consult
;;     valutare anche `cape` come companion package
;; (use-package corfu
;;   :ensure t
;;   :custom
;;   (corfu-auto t)                      ;; completion automatica
;;   (corfu-auto-delay 0.3)              ;; ritardo prima di mostrare i candidati
;;   (corfu-auto-prefix 2)               ;; minimo 2 caratteri prima di attivare
;;   :init
;;   (global-corfu-mode 1))

;;  ————————————————————  cape  ————————————————————————————————————————————  ;;
;; companion package di corfu: estende le sorgenti di completion
;; (file, dabbrev, keyword, elisp, ecc.) - attivare insieme a corfu
;; cfr.: https://github.com/minad/cape
;; (use-package cape
;;   :ensure t
;;   :init
;;   (add-to-list 'completion-at-point-functions #'cape-dabbrev)  ;; parole nel buffer
;;   (add-to-list 'completion-at-point-functions #'cape-file)     ;; path di file
;;   (add-to-list 'completion-at-point-functions #'cape-keyword)) ;; keyword del linguaggio

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                           end of ui-modern.el                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
