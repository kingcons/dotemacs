;; As long as I have to deal with it, this config does too.
(bsb/use-package! coffee-mode
  :mode (("\\.coffee\\'" . coffee-mode)))

;; Use syntax highlighting from web-mode.
(bsb/use-package! web-mode
  :mode (("\\.jsx?\\'" . web-mode))
  :config
  (setq web-mode-content-types-alist '(("jsx" . "\\.jsx?\\'")))
  (setq web-mode-markup-indent-offset 2))

;; (bsb/use-package! add-node-modules-path
;;   :hook (((js-mode) . add-node-modules-path)))

(bsb/use-package! lsp-mode
  :hook ((js-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :config
  (setq lsp-auto-configure t
        lsp-auto-guess-root t))
