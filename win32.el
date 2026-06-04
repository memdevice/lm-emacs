(let ((git-usr-bin "C:/Program Files/Git/usr/bin"))
  (setq exec-path (cons git-usr-bin exec-path))
  (setenv "PATH"
          (concat git-usr-bin ";" (getenv "PATH"))))
