;;; Use selectrum + prescient for better selection interfaces

(bsb/use-package! prescient
  :config
  (selectrum-prescient-mode)
  (prescient-persist-mode 1))

(bsb/use-package! selectrum
  :init (selectrum-mode 1))

;;; Use avy for more pleasant navigation

(bsb/use-package! avy
  :bind (("C-c j" . avy-goto-char-timer)))

(bsb/use-package! ws-butler
  :config
  (ws-butler-global-mode)
  (setq ws-butler-keep-whitespace-before-point nil))
