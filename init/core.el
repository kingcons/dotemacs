;;; use which-key in case you get lost

;; (use-package which-key
;;   :config (which-key-mode))

;;; use marginalia to ease learning

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;;; use vertico for a fast and pleasant minibuffer

(use-package vertico
  :init (vertico-mode))

;;; use orderless for elegant, flexible completions

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;;; use embark for context-aware actions

(use-package embark
  :bind
  (("C-." . embark-act)        ;; pick some comfortable binding
   ("C-;" . embark-dwim)       ;; good alternative: M-.
   ("C-h B" . embark-bindings) ;; alternative for `describe-bindings'
   :map minibuffer-local-completion-map
   ("C-." . embark-act)
   ("C->" . embark-export)
   ("C-<" . embark-become))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

;;; use avy for more pleasant navigation

(use-package avy
  :bind (("M-j" . avy-goto-char-timer)))

;;; Use consult for improved isearch, buffer switching, etc

;; (use-package consult
;;   :bind (("C-c p g" . consult-git-grep)
;;          ("C-x b" . consult-buffer)
;;          ("C-s" . consult-line))
;;   :init (fset 'multi-occur #'consult-multi-occur)
;;   :config
;;   (setq consult-narrow-key "<")
;;   (setq consult-project-root-function #'bsb/find-project-root))

;;; NOTE: Moving asdf config to .profile should fix solargraph path.
;;; Could alternately adopt exec-path-from-shell but would rather avoid it.
;;; Note that Mac OS may not source .profile on login for graphical apps.
