;;; First things first, edit structurally with paredit.

(use-package paredit
  :hook ((emacs-lisp-mode
          lisp-mode
          lisp-interaction-mode
          geiser-mode) . enable-paredit-mode))

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

;;; Add Gabor's Pax documentation and Try testing helpers

(use-package mgl-pax
  :config
  (mgl-pax-hijack-sly-doc-keys)
  (global-set-key (kbd "s-.") 'mgl-pax-document))

(use-package mgl-try)

;;; And geiser for mischievous scheming

(use-package geiser
  :init
  (setq geiser-active-implementations '(guile racket mit)
        geiser-autodoc-identifier-format "%s -> %s"))
