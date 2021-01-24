;;; Use selectrum + prescient for better selection interfaces

(bsb/use-package! selectrum
  :init (selectrum-mode 1))

(bsb/use-package! prescient
  :config
  (prescient-persist-mode 1))

(bsb/use-package! selectrum-prescient
  :config
  (selectrum-prescient-mode))

;;; Use consult for improved isearch, buffer switching, etc

(defun bsb/find-project-root ()
  (cdr (project-try-vc default-directory)))

(bsb/use-package! consult
  :bind (("C-c p g" . consult-git-grep)
         ("C-x b" . consult-buffer)
         ("C-s" . consult-line))
  :init (fset 'multi-occur #'consult-multi-occur)
  :config
  (setq consult-narrow-key "<")
  (setq consult-project-root-function #'bsb/find-project-root))

;;; Use embark for context-aware actions

(bsb/use-package! embark
  :bind (("C-c a" . embark-act))
  :config
  (setq embark-action-indicator
        (lambda (map)
          (which-key--show-keymap "Embark" map nil nil 'no-paging)
          #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator))

(bsb/use-package! embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . embark-consult-preview-minor-mode))

;;; use avy for more pleasant navigation

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
