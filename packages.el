;; Some helpers for interacting with guix and loading packages.
(defun guix-package-installed-p (package)
  (let ((command (format "guix package -I \"^%s$\"" package)))
    (not (string-empty-p (shell-command-to-string command)))))

(defun ensure-package! (guix-package)
  (unless (guix-package-installed-p guix-package)
    (error "The requested package, %s, is not installed locally" guix-package)))

(defun load-package-config (guix-package config-file)
  "Error if the GUIX-PACKAGE is not installed on the local machine.
Otherwise, load the specified CONFIG-FILE from the init folder."
  (ensure-package! guix-package)
  (let ((file-name (format "~/.emacs.d/init/%s.el" config-file)))
    (load-file (expand-file-name file-name))))

;; Use-package is a vast improvement over the old fashioned ways.
(ensure-package! 'emacs-use-package)
(require 'use-package)

;; Configure packages.
(let ((package-map '((emacs-magit "magit"))))
  (dolist (package package-map)
    (let ((system-name (car package))
	  (file-name (cadr package)))
      (load-package-config system-name file-name))))

;; TODO:
;; Initial package list: sly, magit, avy. Maybe notmuch or org?
;; Probably some others I'm forgetting. Check the browser tabs :)
