;;; Use vertico + orderless for better completion

(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :config
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;;; Use consult for improved isearch, buffer switching, etc

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
  :bind (("C-." . embark-act))
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
  :bind (("M-j" . avy-goto-char-timer)))

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

;;; On Mac, ensure that we inherit correct PATH.
(when (memq window-system '(mac ns))
  (use-package exec-path-from-shell
    :init (exec-path-from-shell-initialize)))
