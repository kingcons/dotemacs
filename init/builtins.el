;;; Adjust built-in settings

;; Store non-config data outside ~/.emacs.d
(setq user-emacs-directory "~/.cache/emacs")

(let ((backup-path (expand-file-name "backups" user-emacs-directory))
      (auto-save-path (expand-file-name "autosave/" user-emacs-directory))
      (tramp-save-path (expand-file-name "tramp-autosave/" user-emacs-directory)))
  (setq make-backup-files nil
        backup-directory-alist `((".*" . ,backup-path))
        tramp-backup-directory-alist backup-directory-alist
        auto-save-list-file-prefix auto-save-path
        tramp-auto-save-directory tramp-save-path))

;; Enforce Unicode
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; Skip startup screen
(setq inhibit-startup-screen t)

;; Load new source rather than old bytecode
(setq load-prefer-newer t)

;; Assorted formatting improvements
(setq-default indent-tabs-mode nil) ; Spaces, not tabs
(setq-default fill-column 80) ; Have a wider fill-column
(setq-default truncate-lines t) ; Don't wrap by default
(setq-default word-wrap t) ; But if you do wrap, do it at word boundaries
(add-hook 'text-mode-hook #'visual-line-mode) ; And soft wrap for prose
(setq require-final-newline t) ; Always end files with newlines

;; Require less typing
(defalias 'yes-or-no-p 'y-or-n-p) ; y, not yes
(setq kill-whole-line t) ; C-k once, not twice
