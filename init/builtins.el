;;; Adjust settings of built-in modes.

;; Store non-config data outside ~/.emacs.d
(setq user-emacs-directory "~/.cache/emacs")
(let ((backup-path (expand-file-name "backups" user-emacs-directory))
      (auto-save-path (expand-file-name "autosave" user-emacs-directory)))
  (setq backup-directory-alist `((".*" . ,backup-path))
        auto-save-file-name-transforms `((".*" ,auto-save-path t))))

;; Enforce Unicode
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; Skip startup screen
(setq inhibit-startup-screen t)

;; Load new source rather than old bytecode
(setq load-prefer-newer t)

;; Spaces not tabs, but preserve semantic width of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 8)

;; End files with newlines
(setq require-final-newline t)

;; Require less typing
(defalias 'yes-or-no-p 'y-or-n-p) ; y, not yes
(setq kill-whole-line t) ; C-k once, not twice
