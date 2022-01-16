;;; use marginalia to ease learning

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;;; use which-key in case you get lost

;; (use-package which-key
;;   :config (which-key-mode))

;;; use embark for context-aware actions

(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'
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
