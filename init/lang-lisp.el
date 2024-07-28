;;; First things first, edit structurally with paredit.

(use-package paredit
  :delight
  :hook ((emacs-lisp-mode
          geiser-mode
          lisp-mode
          lisp-interaction-mode
          slime-repl-mode) . enable-paredit-mode))

;;; Use slime for a delightful common lisp experience

(use-package slime
  :config
  (let ((sbcl-path (if (eq system-type 'darwin)
                       "/usr/local/bin/sbcl"
                     "sbcl"))
        (ccl-path (if (eq system-type 'darwin)
                      "/usr/local/bin/ccl64"
                    "ccl")))
    (setq slime-lisp-implementations
          `((sbcl (,sbcl-path "--noinform") :coding-system utf-8-unix)
            (ccl (,ccl-path))))
    ;; KLUDGE: See: https://github.com/slime/slime/issues/643
    ;; A better fix would be slime-c-p-c using a proper CAPF.
    (with-eval-after-load 'slime
      (defun my--slime-completion-at-point ()
        (let ((slime-current-thread :repl-thread)
              (package (slime-current-package)))
          (when-let ((symbol (thing-at-point 'symbol)))
            (pcase-let ((`(,beg . ,end)
                         (bounds-of-thing-at-point 'symbol)))
              (list beg end
                    (car (slime-eval
                          ;; Or swank:simple-completions
                          `(swank:fuzzy-completions
                            ,(substring-no-properties symbol) ',package))))))))
      (advice-add #'slime--completion-at-point
                  :override #'my--slime-completion-at-point))))

;;; Add Gabor's Pax documentation and Try testing helpers

(use-package mgl-pax
  :ensure nil
  :load-path bsb/site-lisp
  :config
  (mgl-pax-hijack-slime-doc-keys)
  (global-set-key (kbd "s-.") 'mgl-pax-document))

(use-package mgl-try)

;;; And geiser for mischievous scheming

(use-package geiser
  :init
  (setq geiser-active-implementations '(guile racket mit)
        geiser-autodoc-identifier-format "%s -> %s"))
