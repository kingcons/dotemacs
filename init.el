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

;; TODO: Running guix package -I per package was killing our startup
;; time to the tune of about ~.25 seconds per package. What we could
;; do though is run it once, capture the output to string, and check
;; for every item from the manifest, throwing a warning if any are
;; not present.

(defun initialize-config! (modules)
  (dolist (module modules)
    (let ((file-name (format "~/.emacs.d/init/%s.el" module)))
      (load-file (expand-file-name file-name)))))

(let ((modules '("appearance"
                 "builtins"
                 "core"
                 "documents"
                 "email"
                 "git"
                 "help"
                 "lang-js"
                 "lang-lisp"
                 "system")))
  (initialize-config! modules))

(message "Initialized in %s" (emacs-init-time))

;; NOTES:
;; Nice to have:
;;; w3m/eww stuff?
;;; mpc/emms?
;;; org-roam
;;; notmuch
;;; elfeed

;; Under Consideration:
;;; browse-kill-ring / expand-region
;;; undo-tree / undo-fu
;;; hydras/hercules
;;; slack/discord
;;; emacs-emojify
;;; youtube-dl
