
;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                          LM init.el - bootstrap                             ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 
(load (expand-file-name "core"         user-emacs-directory))
;; (load (expand-file-name "proxy"    user-emacs-directory))       ; off by default
(load (expand-file-name "functions"    user-emacs-directory))
(load (expand-file-name "packages"     user-emacs-directory))
;; (load (expand-file-name "lm-keybindings" user-emacs-directory))  ; TODO: keybindings - complesso!
(load (expand-file-name "ui-modern"    user-emacs-directory))
(load (expand-file-name "boot"         user-emacs-directory))
;; (when (eq system-type 'windows-nt) (load (expand-file-name "win32" user-emacs-directory)))
;; (load (expand-file-name "sandbox"    user-emacs-directory))     ; off by default
 

