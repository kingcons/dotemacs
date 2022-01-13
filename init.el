;; Preflight checks
(when (version< emacs-version "27.1")
  (error "Emacs version is too old for this config."))

;; Raise GC threshold to 32MB
(setq gc-cons-threshold (* 1024 1024 32))

;; Load some handy libraries
(require 'cl-lib)

(defun bsb/read-file (file)
  (with-temp-buffer
    (insert-file-contents file)
    (buffer-string)))

;; Determine if we're in Guix OS or not
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

;; Add some basic utils for loading the other config files

(defun bsb/find-init-file (name)
  (format "%s/init/%s.el" user-emacs-directory name))

(defun bsb/initialize-config! (modules)
  (let ((files (seq-map #'bsb/find-init-file modules)))
    (seq-each #'load-file files)))

;; Let 'er rip
(let ((modules '("appearance"
                 "builtins")))
  (bsb/initialize-config! modules))

(message "Initialized in %s with %d garbage collections" (emacs-init-time) gcs-done)
