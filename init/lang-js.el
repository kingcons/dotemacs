;; As long as I have to deal with it, this config does too.
(use-package coffee-mode
  :mode (("\\.coffee\\'" . coffee-mode)))

;; Add lsp-mode for more pleasant modern frontend dev.

(use-package add-node-modules-path
  :hook ((js-mode . add-node-modules-path)))

(use-package lsp-mode
  :hook ((js-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :bind (:map js-mode-map
              ("M-." . #'lsp-find-definition)
              ("M-," . #'xref-pop-marker-stack))
  :commands lsp
  :config
  (setq lsp-auto-configure t
        lsp-auto-guess-root t))
