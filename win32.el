;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                        LM win32 configuration                               ;;
;;              impostazioni specifiche per Windows 32/64 bit                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
;;  ————————————————————  Git for Windows: Unix tools  —————————————————————  ;;
;; aggiunge gli eseguibili Unix di Git for Windows al PATH di Emacs
;; (grep, find, ls ecc. disponibili nel terminale Emacs)
(let ((git-usr-bin "C:/Program Files/Git/usr/bin"))
  (setq exec-path (cons git-usr-bin exec-path))
  (setenv "PATH"
          (concat git-usr-bin ";" (getenv "PATH"))))
 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            end of win32.el                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

