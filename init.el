;; Preflight checks
(when (< emacs-major-version 26)
  (error "Emacs version is too old for this config."))

(unless (zerop (shell-command "which guix"))
  (error "This config is designed for the Guix System."))

;; Define a few helpers
(defun init-file-p (filename)
  (equal (file-name-extension filename) "el"))

(defun load-init-file (name &optional dir)
  (let ((file (expand-file-name (format "%s/%s.el" (or dir "~/.emacs.d") name))))
    (load-file file)))

(defun initialize-config! ()
  (load-init-file "builtins")
  (load-init-file "packages")
  (let* ((config-dir "~/.emacs.d/init")
	 (files (directory-files config-dir))
	 (elisp (seq-filter #'init-file-p files)))
    (mapcar #'load-init-file elisp)))

;; Liftoff...
(initialize-config!)
