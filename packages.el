;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        LM packages configuration                            ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  ————————————————————  package.el bootstrap  ————————————————————————————  ;;
(require 'package)
(setq package-archives
      '(("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa"  . "https://melpa.org/packages/")))
(package-initialize)

;; aggiorna il catalogo dei package se non è mai stato scaricato
(unless package-archive-contents
  (package-refresh-contents))

;;  ————————————————————  use-package bootstrap  ———————————————————————————  ;;
;; use-package è built-in da Emacs 29, non serve installarlo
(require 'use-package)
(setq use-package-verbose t)            ;; mostra in *Messages* cosa viene caricato
;;(setq use-package-always-ensure nil)  ;; default: :ensure va dichiarato esplicitamente

;;  ————————————————————  package built-in: dired  —————————————————————————  ;;
(use-package dired
  :config
  ;; (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
  ;; ;; RET non apre nuovi buffer in dired, usa sempre lo stesso buffer
  ;; (define-key dired-mode-map (kbd "^")
  ;;   (lambda () (interactive) (find-alternate-file "..")))
  ;; ;; ^ sale di directory senza aprire nuovo buffer
  ;; (put 'dired-find-alternate-file 'disabled nil)
  )

(use-package dired-x
  :after dired)
;; C-x C-j  →  dired-jump: apre dired nella directory del buffer corrente

;;  ————————————————————  package esterni  —————————————————————————————————  ;;
;; (aggiungi qui i nuovi package con :ensure t)

;;  ————————————————————  standby  —————————————————————————————————————————  ;;
;; (use-package smartscan                ;; M-n / M-p: salta tra simboli identici nel buffer
;;   :ensure t
;;   :config (global-smartscan-mode 1))

;; (use-package lorem-ipsum              ;; inserisce testo lorem ipsum
;;   :ensure t
;;   :config (lorem-ipsum-use-default-bindings))
;; ;; C-c l p: lorem-ipsum-insert-paragraphs
;; ;; C-c l s: lorem-ipsum-insert-sentences
;; ;; C-c l l: lorem-ipsum-insert-list

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            end of packages.el                               ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
