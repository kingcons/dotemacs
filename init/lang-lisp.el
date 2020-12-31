;;; First things first, edit structurally with lispy.

(use-package lispy
  :hook ((lisp-mode . lispy-mode)
         (emacs-lisp-mode . lispy-mode)
         (scheme-mode . lispy-mode))
  :config (setq lispy-close-quotes-at-end-p t))

;;; Add support for extempore in case we want to livecode.

(use-package extempore-mode
  :mode (("\\.xtm\\'" . extempore-mode)))
