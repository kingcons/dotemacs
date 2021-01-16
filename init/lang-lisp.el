;;; First things first, edit structurally with lispy.

(bsb/use-package! lispy
  :hook ((lisp-mode . lispy-mode)
         (emacs-lisp-mode . lispy-mode)
         (scheme-mode . lispy-mode))
  :config (setq lispy-close-quotes-at-end-p t))

;;; Use sly for a delightful common lisp experience

(bsb/use-package! sly
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

(bsb/use-package! sly-macrostep)
(bsb/use-package! sly-quicklisp)

;;; Add support for extempore in case we want to livecode.

(bsb/use-package! extempore-mode
  :mode (("\\.xtm\\'" . extempore-mode)))
