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
  (let ((sbcl-path (if (eq system-type 'darwin)
                       "/usr/local/bin/sbcl"
                     "sbcl"))
        (ccl-path (if (eq system-type 'darwin)
                      "/usr/local/bin/ccl64"
                    "ccl")))
    (setq sly-lisp-implementations
          `((sbcl (,sbcl-path "--noinform") :coding-system utf-8-unix)
            (ccl (,ccl-path))))))

;;; And geiser for mischievous scheming

(use-package geiser
  :init
  (setq geiser-active-implementations '(mit guile)
        geiser-autodoc-identifier-format "%s -> %s"))

;;; Add support for extempore in case we want to livecode.

(use-package extempore-mode
  :mode (("\\.xtm\\'" . extempore-mode)))
