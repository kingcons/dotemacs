;; Preflight checks
(when (version< emacs-version "28")
  (error "Emacs version is too old for this config."))

;; Raise GC threshold to 32MB
(setq gc-cons-threshold (* 1024 1024 32))

;; Determine if we're in Guix OS or not
(defun bsb/read-file (file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

(defvar bsb/guix-system-p
  (and (eq system-type 'gnu/linux)
       (string-match-p "GNU system" (bsb/read-file "/etc/issue"))))

;; Add MELPA and a nice place outside the config for packages to live
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

(setq use-package-always-ensure (not bsb/guix-system-p))

;; Add site-lisp to the load-path for any vendored in dependencies
(add-to-list 'load-path (expand-file-name "site-lisp/" user-emacs-directory))

;; Add some basic utils for loading the other config files and track where
;; the config root is since I use chemacs and will reset user-emacs-directory
(defvar bsb/config-dir
  user-emacs-directory)

(defun bsb/initialize-config! (modules)
  (dolist (module modules)
    (let ((file (format "%s/init/%s.el" bsb/config-dir module)))
      (load-file file))))

;; Let 'er rip
(let ((modules '("appearance"
                 "builtins"
                 "core"
                 "development"
                 "email"
                 "files"
                 "lang-lisp")))
  (bsb/initialize-config! modules))

(message "Initialized in %s with %d garbage collections" (emacs-init-time) gcs-done)
