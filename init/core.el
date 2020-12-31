;;; Use avy + ace-window for more pleasant navigation

(use-package avy
  :bind (("C-c j" . avy-goto-char-2)
         ("C-c J" . avy-goto-line)))

(use-package ace-window
  :bind (("C-c w" . ace-window)))

;;; Use selectrum + prescient for better selection interfaces

(use-package prescient
  :config
  (selectrum-prescient-mode)
  (prescient-persist-mode 1))

(use-package selectrum
  :init (selectrum-mode 1))

;;; TODO: What about consult + embark?

(use-package ws-butler
  :config
  (ws-butler-global-mode)
  (setq ws-butler-keep-whitespace-before-point nil))
