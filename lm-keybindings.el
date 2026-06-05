;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      LM keybindings                                         ;;
;;         sistema organizzato per famiglie con prefisso C-c                   ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;  REGOLE DEL SISTEMA DI KEYBINDINGS LM
;;  ——————————————————————————————————————————————————————————————————————————
;;  1. FAMIGLIA:   C-c <lettera> raggruppa azioni dello stesso tipo semantico
;;  2. MAIUSCOLA:  C-c X è variante avanzata/opposta/inversa/infrequente di C-c x
;;  3. ERGONOMICA: comodità del tasto proporzionale a naturalezza/frequenza
;;                 azione naturale/frequente → tasto comodo (minuscola)
;;                 azione opposta/infrequente → tasto scomodo (maiuscola)
;;  4. PACKAGE:    si usano i kb proposti dal package se non confliggono;
;;                 altrimenti si cerca qualcosa di simile
;;  5. ORDINE:     il kb precede sempre la funzione o il package che usa;
;;                 il commento descrittivo segue sempre il blocco
;;  6. POSIZIONE:  kb con famiglia → lm-keybindings.el
;;                 kb senza famiglia → core.el
;;  ——————————————————————————————————————————————————————————————————————————
;;
;;  MAPPA FAMIGLIE
;;  ——————————————————————————————————————————————————————————————————————————
;;  C-c i     insert (testo, date, random ecc.)
;;  C-c i r   insert random (number, string, hex)
;;  C-c i l   insert lorem ipsum
;;  C-c k/K   kill line / kill paragraph
;;  C-c y/Y   copy line / duplicate line
;;  C-c o/O   open line below / above
;;  C-c j/J   join line above / below
;;  C-c s     search
;;  C-c r     replace
;;  C-c v     view (zoom, visual-line ecc.)
;;  C-c b     buffer
;;  C-c e     edit vario
;;  C-c w     web
;;  C-c d     dict (dizionario, thesaurus)
;;  C-c x     eXecute/eval lisp
;;  C-c f     file rapidi predefiniti
;;  C-c t     test
;;  ——————————————————————————————————————————————————————————————————————————

;;  ————————————————————  C-c i : insert  ——————————————————————————————————  ;;
;; C-c i d — data ISO format   (2021-02-19)
;; C-c i o — data ordinale     (2021-050)
;; C-c i t — ora               (14:58:25 +0100)
;; C-c i u — UNIX time         (1613743116)
(global-set-key (kbd "C-c i d") 'mp-insert-date)
(global-set-key (kbd "C-c i o") 'mp-insert-ordinal-date)
(global-set-key (kbd "C-c i t") 'mp-insert-time)
(global-set-key (kbd "C-c i u") (lambda () (interactive) (insert (format-time-string "%s"))))
;; cfr. functions.el: mp-insert-date, mp-insert-ordinal-date, mp-insert-time

;;  ————————————————————  C-c i r : insert random  —————————————————————————  ;;
;; C-c i r n — numero casuale (5 cifre default, C-u N per lunghezza diversa)
;; C-c i r s — stringa alfanumerica casuale (16 caratteri default)
;; C-c i r h — stringa esadecimale casuale (12 caratteri default)
;; (global-set-key (kbd "C-c r n") 'xah-insert-random-number)  ;; vecchio kb
;; (global-set-key (kbd "C-c r s") 'xah-insert-random-string)  ;; vecchio kb
;; (global-set-key (kbd "C-c r h") 'xah-insert-random-hex)     ;; vecchio kb
(global-set-key (kbd "C-c i r n") 'xah-insert-random-number)
(global-set-key (kbd "C-c i r s") 'xah-insert-random-string)
(global-set-key (kbd "C-c i r h") 'xah-insert-random-hex)
;; cfr. functions.el: xah-insert-random-number/string/hex

;;  ————————————————————  C-c i : insert vario  ————————————————————————————  ;;
;; C-c C-f — inserisce filename al punto
;; C-c C-t — inserisce template timestamp LM
;; C-c C-n — inserisce glossa LM [LM:   ]
(global-set-key (kbd "C-c C-f") 'my-insert-file-name)
(global-set-key (kbd "C-c C-t") 'lm-insert-time-stamp-template)
(global-set-key (kbd "C-c C-n") 'my-insert-lm-glossa)
;; cfr. functions.el: my-insert-file-name, lm-insert-time-stamp-template, my-insert-lm-glossa

;;  ————————————————————  C-c i l : insert lorem ipsum  ————————————————————  ;;
;; (global-set-key (kbd "C-c l p") 'lorem-ipsum-insert-paragraphs)  ;; vecchio kb
;; (global-set-key (kbd "C-c l s") 'lorem-ipsum-insert-sentences)   ;; vecchio kb
;; (global-set-key (kbd "C-c l l") 'lorem-ipsum-insert-list)        ;; vecchio kb
(global-set-key (kbd "C-c i l p") 'lorem-ipsum-insert-paragraphs)
(global-set-key (kbd "C-c i l s") 'lorem-ipsum-insert-sentences)
(global-set-key (kbd "C-c i l l") 'lorem-ipsum-insert-list)
;; cfr. packages.el: lorem-ipsum (standby, decommentare per attivare)

;;  ————————————————————  C-c k/K : kill  ——————————————————————————————————  ;;
;; C-c k — kill whole line (ex C-c d)
;; C-c K — kill paragraph
;; (global-set-key (kbd "C-c d") 'kill-whole-line)  ;; vecchio kb - C-c d ora è dict
(global-set-key (kbd "C-c k") 'kill-whole-line)
(global-set-key (kbd "C-c K") 'kill-paragraph)
;; regola maiuscola: K uccide più di k (paragrafo vs riga)

;;  ————————————————————  C-c y/Y : copy/duplicate  ————————————————————————  ;;
;; C-c y — copia la riga (va nel kill ring) — VI: yy
;; C-c Y — duplica la riga (copia e incolla sotto) — VI: yyp
;; C-u N C-c y — copia N righe
(global-set-key (kbd "C-c y") 'copy-line)
(global-set-key (kbd "C-c Y") 'duplicate-line)
;; cfr. functions.el: copy-line, duplicate-line

;;  ————————————————————  C-c o/O : open line  —————————————————————————————  ;;
;; C-c o — apri riga sotto (VI: o)
;; C-c O — apri riga sopra (VI: O)
;; regola direzionale: minuscola=sotto (naturale), maiuscola=sopra (opposto)
(global-set-key (kbd "C-c o")          'smart-open-line)
(global-set-key (kbd "C-c O")          'smart-open-line-above)
(global-set-key [(shift return)]       'smart-open-line)        ;; alias comodo
(global-set-key [(control shift return)] 'smart-open-line-above) ;; alias comodo
;; cfr. functions.el: smart-open-line, smart-open-line-above

;;  ————————————————————  C-c j/J : join line  —————————————————————————————  ;;
;; C-c j — unisci con riga sopra (direzione naturale)
;; C-c J — unisci con riga sotto (direzione opposta)
;; regola direzionale: simmetrico a o/O
;; (global-set-key (kbd "C-c j") 'join-line)  ;; vecchio kb (stesso chord, stessa funzione)
(global-set-key (kbd "C-c j") 'join-line)
(global-set-key (kbd "C-c J") (lambda () (interactive) (join-line 1)))
;; join-line è nativa Emacs (alias delete-indentation)

;;  ————————————————————  C-c s : search  ——————————————————————————————————  ;;
;; C-c s o — occur nel buffer (ex C-c o)
;; C-c s l — consult-line (ricerca riga nel buffer)
;; C-c s g — consult-grep
;; C-c s G — consult-git-grep
;; (global-set-key (kbd "C-c o") 'occur)  ;; vecchio kb
(global-set-key (kbd "C-c s o") 'occur)
(global-set-key (kbd "C-c s l") 'consult-line)
(global-set-key (kbd "C-c s g") 'consult-grep)
(global-set-key (kbd "C-c s G") 'consult-git-grep)
;; cfr. ui-modern.el: consult

;;  ————————————————————  C-c r : replace  —————————————————————————————————  ;;
;; C-c r r — query-replace-regexp (ex C-c r)
;; C-c r s — query-replace (semplice, senza regexp)
;; (global-set-key (kbd "C-c r") 'query-replace-regexp)  ;; vecchio kb
(global-set-key (kbd "C-c r r") 'query-replace-regexp)
(global-set-key (kbd "C-c r s") 'query-replace)
;; regola maiuscola: r=regexp (più potente), s=semplice (meno potente) - inversione intenzionale

;;  ————————————————————  C-c v : view  ————————————————————————————————————  ;;
;; C-c v v — visual-line-mode (ex C-c v)
;; C-c v + — text-scale-increase (ex C-c +)
;; C-c v - — text-scale-decrease (ex C-c -)
;; (global-set-key (kbd "C-c v") 'visual-line-mode)      ;; vecchio kb
;; (global-set-key (kbd "C-c +") 'text-scale-increase)   ;; vecchio kb
;; (global-set-key (kbd "C-c -") 'text-scale-decrease)   ;; vecchio kb
(global-set-key (kbd "C-c v v") 'visual-line-mode)
(define-key global-map (kbd "C-c v +") 'text-scale-increase)
(define-key global-map (kbd "C-c v -") 'text-scale-decrease)

;;  ————————————————————  C-c b : buffer  ——————————————————————————————————  ;;
;; C-c b b — consult-buffer (switch buffer arricchito)
;; C-c b k — kill current buffer
;; C-c b K — kill all other buffers
;; C-c b i — ibuffer
;; C-c b B — bury buffer
;; (global-set-key (kbd "C-c B") 'bury-buffer)  ;; vecchio kb
(global-set-key (kbd "C-c b b") 'consult-buffer)
(global-set-key (kbd "C-c b k") 'kill-current-buffer)
(global-set-key (kbd "C-c b K") 'kill-other-buffers)
(global-set-key (kbd "C-c b i") 'ibuffer)
(global-set-key (kbd "C-c b B") 'bury-buffer)
;; cfr. ui-modern.el: consult; functions.el: kill-other-buffers

;;  ————————————————————  C-c e : edit vario  ——————————————————————————————  ;;
;; C-c e u — unfill-paragraph (ex M-q swap)
;; C-c e U — fill-paragraph (ex M-Q swap)
;; regola maiuscola: U=fill (aggiunge), u=unfill (toglie) — U è più "distruttivo"
(global-set-key (kbd "C-c e u") 'unfill-paragraph)
(global-set-key (kbd "C-c e U") 'fill-paragraph)
;; cfr. functions.el: unfill-paragraph
;; NB: M-q e M-Q restano in functions.el come swap nativi

;;  ————————————————————  C-c w : web  —————————————————————————————————————  ;;
;; C-c w g — cerca su Google
;; C-c w y — cerca su YouTube
;; (global-set-key (kbd "C-c C-w g") #'er-google)   ;; vecchio kb
;; (global-set-key (kbd "C-c C-w y") #'er-youtube)  ;; vecchio kb
(global-set-key (kbd "C-c w g") #'er-google)
(global-set-key (kbd "C-c w y") #'er-youtube)
;; cfr. functions.el: er-google, er-youtube

;;  ————————————————————  C-c d : dict  ————————————————————————————————————  ;;
;; C-c d t — mthesaur: ricerca nel thesaurus offline
;; (global-set-key (kbd "C-c t") 'mthesaur-search)  ;; vecchio kb
(global-set-key (kbd "C-c d t") 'mthesaur-search)
;; cfr. packages.el: mthesaur (da aggiungere)

;;  ————————————————————  C-c x : eXecute/eval  ————————————————————————————  ;;
;; C-c x b — eval-buffer   (ex C-c C-j)
;; C-c x r — eval-region
;; C-c x x — eval-last-sexp (nativo C-x C-e, alias comodo)
;; C-c x d — eval-defun
;; (global-set-key (kbd "C-c C-j") 'eval-buffer)  ;; vecchio kb
(global-set-key (kbd "C-c x b") 'eval-buffer)
(global-set-key (kbd "C-c x r") 'eval-region)
(global-set-key (kbd "C-c x x") 'eval-last-sexp)
(global-set-key (kbd "C-c x d") 'eval-defun)

;;  ————————————————————  C-c f : file rapidi  —————————————————————————————  ;;
;; C-c f n — note.org
;; C-c f f — F-T-G.org
;; C-c f z — zibalduccio.org
;; C-c f o — organizer.org
;; TODO: spostare e modificare quando si crea il file note dedicato
;; (global-set-key (kbd "C-c n") ...) ;; vecchio kb note.org
;; (global-set-key (kbd "C-c f") ...) ;; vecchio kb F-T-G.org
;; (global-set-key (kbd "C-c z") ...) ;; vecchio kb zibalduccio.org
(global-set-key (kbd "C-c f n") (lambda () (interactive) (find-file "~/note.org")))
(global-set-key (kbd "C-c f f") (lambda () (interactive) (find-file "~/F-T-G.org")))
(global-set-key (kbd "C-c f z") (lambda () (interactive) (find-file "~/zibalduccio.org")))
(global-set-key (kbd "C-c f o") (lambda () (interactive) (find-file "~/organizer.org")))
(setq org-default-notes-file "~/organizer.org")
(global-set-key (kbd "C-c f c") 'org-capture)
;; cfr. TODO: file note dedicato

;;  ————————————————————  C-c t : test  ————————————————————————————————————  ;;
;; C-c t b — ding: test bell (ex C-c b)
;; (global-set-key (kbd "C-c b") 'ding)  ;; vecchio kb
(global-set-key (kbd "C-c t b") 'ding)
;; C-c q — enlightenment: frase casuale da ~/.random-lines.txt
;; (global-set-key (kbd "C-c q") 'enlightenment-for-today)  ;; standby
;; cfr. functions.el: enlightenment-for-today

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        end of lm-keybindings.el                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
