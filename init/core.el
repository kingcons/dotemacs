;;; Use selectrum + orderless for better narrowing and completion styles

(use-package selectrum
  :init (selectrum-mode 1))

(use-package orderless
  :config
  (setq completion-styles '(orderless))
  (setq selectrum-refine-candidates-function #'orderless-filter)
  (setq selectrum-highlight-candidates-function #'orderless-highlight-matches))

;;; Use consult for improved isearch, buffer switching, etc

(defun bsb/find-project-root ()
  (cdr (project-try-vc default-directory)))

(use-package consult
  :bind (("C-c p g" . consult-git-grep)
         ("C-x b" . consult-buffer)
         ("C-s" . consult-line))
  :init (fset 'multi-occur #'consult-multi-occur)
  :config
  (setq consult-narrow-key "<")
  (setq consult-project-root-function #'bsb/find-project-root))

;;; Use embark for context-aware actions

(use-package embark
  :bind (("C-c a" . embark-act))
  :config
  (setq embark-action-indicator
        (lambda (map)
          (which-key--show-keymap "Embark" map nil nil 'no-paging)
          #'which-key--hide-popup-ignore-command)
        embark-become-indicator embark-action-indicator))

(use-package embark-consult
  :after (embark consult)
  :hook (embark-collect-mode . embark-consult-preview-minor-mode))

;;; use avy for more pleasant navigation

(use-package avy
  :bind (("C-c j" . avy-goto-char-timer)))

;;; use expand-region for selecting text semantically

(use-package expand-region
  :bind (("C-=" . er/expand-region)))

;;; Use company for autocompletion

(use-package company
  :hook (after-init . global-company-mode)
  :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous))
  :init
  (setq company-tooltip-align-annotations t
        company-idle-delay 0.2))

;;; If collaborating with others, conform to their standards.

(use-package ws-butler
  :config
  (ws-butler-global-mode)
  (setq ws-butler-keep-whitespace-before-point nil))

(use-package editorconfig
  :config
  (editorconfig-mode 1)
  (setq editorconfig-trim-whitespaces-mode 'ws-butler-mode))
