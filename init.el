;; Preflight checks
(when (version< emacs-version "26.1")
  (error "Emacs version is too old for this config."))

(unless (executable-find "guix")
  (error "This config is designed for the Guix System."))

;; Be Lispier
(require 'subr-x)
(require 'cl-lib)

;; Use-package is a vast improvement over the old fashioned ways.
(require 'use-package)

(defun initialize-config! (modules)
  (dolist (module modules)
    (let ((file-name (format "~/.emacs.d/init/%s.el" module)))
      (load-file (expand-file-name file-name)))))

(let ((modules '("aesthetics"
                 "builtins"
                 "core"
                 "documents"
                 "git"
                 "help"
                 "lisp")))
  (initialize-config! modules))

(message "Initialized in %s" (emacs-init-time))

;; NOTES:
;;; Still need to configure at least whitespace for builtins.
;;; * something for ruby? something for ocaml and c?

;; Nice to have:
;;; w3m/eww stuff?
;;; mpc/emms?
;;; emacs-guix
;;; org-roam
;;; notmuch
;;; elfeed

;; Under Consideration:
;;; hydras/hercules/general.el
;;; browse-kill-ring
;;; slack/discord
;;; youtube-dl
;;; undo-tree
