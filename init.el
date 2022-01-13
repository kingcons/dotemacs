;; Preflight checks
(when (version< emacs-version "27.1")
  (error "Emacs version is too old for this config."))

(defvar bsb/guix-system-p (executable-find "guix"))

(unless bsb/guix-system-p
  (setq use-package-always-ensure t)
  (message "No Guix installation found. Defaulting to use-package's ensure!"))

;; Ensure MELPA is available and our .emacs.d won't become cluttered
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(setq package-user-dir "~/.cache/emacs/packages")
(setq package-gnupghome-dir "~/.cache/emacs/gnupg")
(package-initialize)

;; Use-package is a vast improvement over the old fashioned ways.
(unless (require 'use-package nil t)
  (unless package-archive-contents
    (package-refresh-contents))
  (package-install 'use-package)
  (require 'use-package))

(defun bsb/find-init-file (name)
  (format "%s/init/%s.el" user-emacs-directory name))

(defun bsb/initialize-config! (modules)
  (let ((files (seq-map #'bsb/find-init-file modules)))
    (seq-each #'load-file files)))

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
                 "music"
                 "system")))
  (bsb/initialize-config! modules))

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
