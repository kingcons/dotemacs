;; Remove aesthetic cruft
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Enforce Unicode
(when (fboundp 'set-charset-priority)
  (set-charset-priority 'unicode))
(prefer-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)

;; Load new source rather than old bytecode
(setq load-prefer-newer t)

;; Require less typing
(defalias 'yes-or-no-p 'y-or-n-p) ; y, not yes
(setq kill-whole-line t) ; C-k once, not twice

;; Be Lispier
(require 'subr-x)
(require 'cl-lib)
