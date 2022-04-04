
;; Time-stamp: <2022-03-08 17:38:36 f205200>

;; ―――――――――――――――――――  cygwin shell   ――――――――――――――――――――――――――――――――――――――  ;;

;; LM: usare la bash di cygwin
;; da: https://www.masteringemacs.org/article/running-shells-in-emacs-overview
;;
(setq explicit-shell-file-name "c:/cygwin64/bin/bash.exe")
(setq shell-file-name "bash")
(setq explicit-bash.exe-args '("--noediting" "--login" "-i"))
(setenv "SHELL" shell-file-name)
(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

;; ―――――――――――――――――――  fortune scratch   ―――――――――――――――――――――――――――――――――――  ;;

;; Supply a random fortune cookie as the *scratch* message.
;; (using internal function.el...)
 (when (executable-find "fortune")
   (setq initial-scratch-message
         (with-temp-buffer
           (shell-command "fortune" t)
           (let ((comment-start ";;"))
             (comment-region (point-min) (point-max)))
           (concat (buffer-string) "\n"))))

;; NB: se non si abilita il path di ricerca dei comandi cygwin non funziona
;;  —————————————————————————————————————————————————————————————————————————  ;;
