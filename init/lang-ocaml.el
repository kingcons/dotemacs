(use-package tuareg
  :after eglot
  :hook (tuareg-mode . eglot-ensure)
  :mode (("\\.ml[ily]?$" . tuareg-mode)
         ("\\.topml$" . tuareg-mode))
  :config
  (add-to-list 'eglot-server-programs '(tuareg-mode . ("ocamllsp")))
  (put 'tuareg-mode 'eglot-language-id "ocaml"))

(use-package merlin
  :hook (tuareg-mode . merlin-mode)
  :config (setq merlin-completion-with-doc t))

(use-package utop)
