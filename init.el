;; Preflight checks
(when (< emacs-major-version 26)
  (error "Emacs version is too old for this config."))

(unless (zerop (shell-command "which guix"))
  (error "This config is designed for the Guix System."))

;; Define a few helpers
(defun load-init-file (name)
  (let ((file (expand-file-name (format "~/.emacs.d/%s.el" name))))
    (load-file file)))

(defun initialize-config! ()
  (load-init-file "builtins")
  (load-init-file "packages"))

;; Liftoff...
(initialize-config!)
