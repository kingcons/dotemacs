(use-package norns
  :config
  (add-hook 'lua-mode-hook #'norns-mode-maybe-activate)
  (add-hook 'sclang-mode-hook #'norns-mode-maybe-activate))
