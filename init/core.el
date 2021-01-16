;;; Use selectrum + prescient for better selection interfaces

(bsb/use-package! selectrum
  :init (selectrum-mode 1))

(bsb/use-package! prescient
  :config
  (prescient-persist-mode 1))

(bsb/use-package! selectrum-prescient
  :config
  (selectrum-prescient-mode))

;;; Use avy for more pleasant navigation

(bsb/use-package! avy
  :bind (("C-c j" . avy-goto-char-timer)))

;;; Use company for autocompletion

(bsb/use-package! company
  :hook (after-init . global-company-mode)
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))
  :init
  (setq company-tooltip-align-annotations t
        company-idle-delay 0.2))

(bsb/use-package! company-prescient
  :config (company-prescient-mode))

;;; If collaborating with others, conform to their standards.

(bsb/use-package! ws-butler
  :config
  (ws-butler-global-mode)
  (setq ws-butler-keep-whitespace-before-point nil))

(bsb/use-package! editorconfig
  :config
  (editorconfig-mode 1)
  (setq editorconfig-trim-whitespaces-mode 'ws-butler-mode))
