;;; First things first, edit structurally with paredit.

(use-package paredit
  :hook ((emacs-lisp-mode
          lisp-mode
          lisp-interaction-mode
          geiser-mode
          sly-mrepl-mode) . enable-paredit-mode))

;;; Use sly for a delightful common lisp experience

(use-package sly
  :config
  (let ((sbcl-path (if bsb/guix-system-p
                       "sbcl"
                     "/usr/local/bin/sbcl"))
        (ccl-path (if bsb/guix-system-p
                      "ccl"
                    "/usr/local/bin/ccl64")))
    (setq sly-lisp-implementations
          `((sbcl (,sbcl-path "--noinform") :coding-system utf-8-unix)
            (ccl (,ccl-path))))))

(use-package sly-macrostep)
(use-package sly-quicklisp)

;;; And geiser for mischievous scheming

(use-package geiser
  :init
  (setq geiser-active-implementations '(mit guile)
        geiser-autodoc-identifier-format "%s -> %s"))

;;; Add support for extempore in case we want to livecode.

(use-package extempore-mode
  :mode (("\\.xtm\\'" . extempore-mode)))
