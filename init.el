;; Preflight checks
(when (version< emacs-version "27.1")
  (error "Emacs version is too old for this config."))

(defvar bsb/guix-system-p (executable-find "guix"))

(unless bsb/guix-system-p
  (message "No Guix installation found. Defaulting to use-package :ensure!"))

;; Raise GC threshold to 24MB
(setq gc-cons-threshold (* 1024 1024 24))

;; Ensure MELPA is available and our .emacs.d won't become cluttered
(require 'package)
(setq custom-file "~/.cache/emacs/custom.el")
(setq package-user-dir "~/.cache/emacs/packages")
(setq package-gnupghome-dir "~/.cache/emacs/gnupg")
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Use-package is a vast improvement over the old fashioned ways.
(unless (require 'use-package nil t)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'use-package)
  (require 'use-package))

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
                 "lang-ruby"
                 "system")))
  (initialize-config! modules))

(message "Initialized in %s" (emacs-init-time))

;; NOTES:
;; Nice to have:
;;; w3m/eww stuff?
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
