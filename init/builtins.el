;;; Adjust built-in settings

;; Store non-config data outside ~/.emacs.d
(setq user-emacs-directory "~/.cache/emacs")
(setq custom-file "~/.cache/emacs/custom.el")
(setq url-configuration-directory "~/.cache/emacs/url/")

;; Skip the auto-save and backup gunk
(setq create-lockfiles nil
      make-backup-files nil
      auto-save-default nil
      auto-save-list-file-prefix nil)

;; Enforce Unicode
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; Skip startup screen
(setq inhibit-startup-screen t)

;; Load new source rather than old bytecode
(setq load-prefer-newer t)

;; Shut the bell up
(setq ring-bell-function 'ignore)

;; Assorted formatting improvements
(setq-default indent-tabs-mode nil) ; Spaces, not tabs
(setq-default fill-column 80) ; Have a wider fill-column
(setq-default truncate-lines t) ; Don't wrap by default
(setq-default word-wrap t) ; But if you do wrap, do it at word boundaries
(add-hook 'text-mode-hook #'visual-line-mode) ; And soft wrap for prose
(setq require-final-newline t) ; Always end files with newlines
(setq sentence-end-double-space nil) ; I separate with a single space

;; Require less typing
(defalias 'yes-or-no-p 'y-or-n-p) ; y, not yes
(setq kill-whole-line t) ; C-k once, not twice

;; Add friendlier keybinding for navigation
(global-set-key (kbd "M-o") 'other-window)

;; TODO: Consider project.el tweaks, tab-mode, etc.
