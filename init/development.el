;;; Use eglot for lsp-support

(use-package eglot)

;;; If collaborating with others, conform to their standards.

(use-package editorconfig
  :delight
  :config
  (editorconfig-mode 1))

;;; Speaking of collaboration, use magit and forge to get more done.

(use-package magit
  :bind (("C-x g" . magit-status)
         ("C-c g" . magit-file-dispatch)))

;; TODO: Forge feels like a lot, decide whether to invest later.

;; (use-package forge
;;   :after magit)

;;; use corfu for prettier completions

(use-package corfu
  :init
  (global-corfu-mode))

;;; use tempel for the repetitive stuff

(use-package tempel
  :bind (("M-+" . tempel-complete)
         ("M-*" . tempel-insert))
  :init
  (setq tempel-path (expand-file-name "templates/*.eld" bsb/config-dir))
  (defun tempel-setup-capf ()
    (setq-local completion-at-point-functions
                (cons #'tempel-expand
                      completion-at-point-functions)))
  (add-hook 'prog-mode-hook #'tempel-setup-capf))

;;; enhance project with project-x

(use-package project-x
  :after project
  :ensure nil
  :load-path bsb/site-lisp
  :config
  (setq project-x-save-interval 300)
  (project-x-mode 1))

;; TODO: Maybe add formatting tools, wsbutler, flymake, etc?
