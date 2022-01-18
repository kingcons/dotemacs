;;; Use eglot for lsp-support

(use-package eglot)

;;; If collaborating with others, conform to their standards.

(use-package editorconfig
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
  (corfu-global-mode))

;; TODO: Maybe add corfu, formatting tools, wsbutler, flymake, etc?
