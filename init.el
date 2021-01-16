;; Preflight checks
(when (version< emacs-version "26.1")
  (error "Emacs version is too old for this config."))

(defvar bsb/guix-system-p (executable-find "guix"))

(unless bsb/guix-system-p
  (message "No Guix installation found. Defaulting to use-package :ensure!"))

;; Raise GC threshold to 24MB
(setq gc-cons-threshold (* 1024 1024 24))

;; Be Lispier
(require 'subr-x)
(require 'cl-lib)

;; Ensure we have MELPA in our list of package archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Use-package is a vast improvement over the old fashioned ways.
(require 'use-package)

(defmacro bsb/use-package! (name &rest body)
  `(use-package ,name
     :ensure ,(null bsb/guix-system-p)
     ,@body))

(put 'bsb/use-package! 'lisp-indent-function 'defun)

(defun initialize-config! (modules)
  (dolist (module modules)
    (let ((file-name (format "~/.emacs.d/init/%s.el" module)))
      (load-file (expand-file-name file-name)))))

;; Let 'er rip
(let ((modules '("appearance"
                 "builtins"
                 "core"
                 "documents"
                 "email"
                 "git"
                 "help"
                 "irc"
                 "lang-js"
                 "lang-lisp"
                 "system")))
  (initialize-config! modules))

(message "Initialized in %s" (emacs-init-time))

;; NOTES:
;; Nice to have:
;;; w3m/eww stuff?
;;; company-mode?
;;; mpc/emms?
;;; org-roam
;;; elfeed

;; Under Consideration:
;;; browse-kill-ring / expand-region
;;; undo-tree / undo-fu
;;; hydras/hercules
;;; slack/discord
;;; emacs-emojify
;;; youtube-dl
