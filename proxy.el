;; Time-stamp: <>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                         LM proxy configuration                              ;;
;;         credenziali proxy richieste solo se ci sono package da scaricare    ;;
;;         caricare PRIMA di packages.el (cfr. init.el)                        ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;  ————————————————————  variabili  ———————————————————————————————————————  ;;
(defvar proxy-username "UTENZE"
  "Proxy LDAP username (domain prefix)")

(defvar proxy-password-cached nil
  "Cached proxy password (in memory only, never on disk)")

(defvar proxy-host "itaca-prod.utenze.bankit.it"
  "Proxy server hostname")

(defvar proxy-port "8080"
  "Proxy server port")

;;  ————————————————————  funzioni  ————————————————————————————————————————  ;;
(defun proxy-get-credentials (&optional no-activate)
  "Chiedi e memorizza le credenziali proxy. Password cachata in memoria."
  (interactive)
  ;; Chiedi username (con default)
  (setq proxy-username
        (read-string (format "Proxy username [%s]: " proxy-username)
                     nil nil proxy-username))
  ;; Chiedi password solo se non è già in cache
  (unless proxy-password-cached
    (setq proxy-password-cached
          (read-passwd (format "Proxy password for %s: " proxy-username)))
    ;; Configura url-proxy-services
    (let* ((auth-string (format "%s\\\\%s:%s" "UTENZE" proxy-username proxy-password-cached))
           (encoded-auth (base64-encode-string auth-string t)))
      (setq url-proxy-services
            `(("no_proxy" . "^\\(localhost\\|127\\.0\\.0\\.1\\|10\\..*\\|192\\.168\\..*\\)")
              ("http"  . ,(format "%s:%s" proxy-host proxy-port))
              ("https" . ,(format "%s:%s" proxy-host proxy-port))))
      (setq url-http-proxy-basic-auth-storage
            (list (list (format "%s:%s" proxy-host proxy-port)
                        (cons "Proxy Authentication" encoded-auth))))
      (message "✓ Proxy configurato: %s:%s (utente: %s)"
               proxy-host proxy-port proxy-username))))

(defun proxy-clear-cache ()
  "Pulisci la password dalla cache (verrà richiesta al prossimo uso)."
  (interactive)
  (setq proxy-password-cached nil)
  (setq url-proxy-services nil)
  (setq url-http-proxy-basic-auth-storage nil)
  (message "✓ Proxy cache cleared"))

;;  ————————————————————  attivazione automatica  ——————————————————————————  ;;
;; Si attiva SOLO quando package-install sta per scaricare un package
;; mancante: se tutto è già installato non chiede nulla.
(defun proxy-activate-if-needed (pkg &optional _dont-select)
  "Attiva il proxy solo se il package PKG non è ancora installato."
  (unless (package-installed-p pkg)
    (unless proxy-password-cached
      (message "Package '%s' mancante - configurazione proxy necessaria..." pkg)
      (proxy-get-credentials))))

(advice-add 'package-install :before #'proxy-activate-if-needed)

(defun proxy-activate-for-refresh ()
  "Attiva il proxy prima di scaricare il catalogo dei package."
  (unless proxy-password-cached
    (message "Scarico catalogo package - configurazione proxy necessaria...")
    (proxy-get-credentials)))

(advice-add 'package-refresh-contents :before #'proxy-activate-for-refresh)

;;  ————————————————————  keybindings  —————————————————————————————————————  ;;
;; NB: verificare conflitti in lm-keybindings.el (C-c C-p occupato in org-mode)
(global-set-key (kbd "C-c C-p") 'proxy-get-credentials) ;; configura proxy manualmente
(global-set-key (kbd "C-c C-l") 'proxy-clear-cache)     ;; pulisci cache password

;;  ————————————————————————————————————————————————————————————————————————  ;;
(message "proxy.el caricato - credenziali richieste solo se necessario")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                            end of proxy.el                                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
