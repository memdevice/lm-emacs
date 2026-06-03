;; Proxy configuration with password caching for Emacs
;; Richiede password interattivamente e la cachea in memoria
;; 2026-06-03 by EXE

(defvar proxy-username "UTENZE"
  "Proxy LDAP username (domain prefix)")

(defvar proxy-password-cached nil
  "Cached proxy password (in memory only)")

(defvar proxy-host "itaca-prod.utenze.bankit.it"
  "Proxy server hostname")

(defvar proxy-port "8080"
  "Proxy server port")

(defun proxy-get-credentials ()
  "Get or prompt for proxy credentials, cache password in memory."
  (interactive)

;; Chiedi username se non è impostato
(setq proxy-username
        (read-string (format "Proxy username [%s]: " proxy-username)
                     nil nil proxy-username))

;; Chiedi password (nascosta) se non è cachata
(unless proxy-password-cached
  (setq proxy-password-cached
          (read-passwd (format "Proxy password for %s: " proxy-username))))

;; Crea stringa auth
(let* ((auth-string (format "%s\\\\%s:%s" "UTENZE" proxy-username proxy-password-cached))
         (encoded-auth (base64-encode-string auth-string t)))

;; Configura Emacs proxy con auth
(setq url-proxy-services
  `(("no_proxy" . "^\\(localhost\\|127\\.0\\.0\\.1\\|10\\..*\\|192\\.168\\..*\\)")
          ("http" . ,(format "%s:%s" proxy-host proxy-port))
          ("https" . ,(format "%s:%s" proxy-host proxy-port))))

;; Configura autenticazione proxy
(setq url-http-proxy-basic-auth-storage
      (list (list (format "%s:%s" proxy-host proxy-port)
                  (cons "Proxy Authentication"
                        encoded-auth))))

(message "✓ Proxy configured: %s:%s (authenticated as %s)"
             proxy-host proxy-port proxy-username)))

(defun proxy-clear-cache ()
  "Pulisci password dalla cache (richiederà nuova auth al prossimo uso)."
  (interactive)
  (setq proxy-password-cached nil)
  (message "✓ Proxy password cache cleared"))

;; Auto-configure al caricamento
(when (eq system-type 'gnu/linux)
  (add-hook 'emacs-startup-hook
            (lambda ()
              (proxy-get-credentials))))

;; Shortcut per riconfigurare
(global-set-key (kbd "C-c C-p") 'proxy-get-credentials)
(global-set-key (kbd "C-c C-l") 'proxy-clear-cache)

(message "Proxy configuration loaded. Press C-c C-p to configure proxy.")
