;;; add a helper for context switching

(defun bsb/store-windows (&rest args)
  (window-configuration-to-register :bsb-fullscreen)
  (delete-other-windows))

(defun bsb/restore-windows (&rest args)
  (jump-to-register :bsb-fullscreen))

;;; use which-key in case you get lost

(use-package which-key
  :config (which-key-mode))

;;; use marginalia to ease learning

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

;;; use vertico for a quick and pleasant minibuffer

(use-package vertico
  :init (vertico-mode))

;;; use orderless for elegant, flexible completions

(defun bsb/ignoring-dispatcher (pattern _index _total)
  (when (string-prefix-p "!" pattern)
    `(orderless-without-literal . ,(substring pattern 1))))

(defun bsb/initials-dispatcher (pattern _index _total)
  (when (string-suffix-p "~" pattern)
    `(orderless-initialism . ,(substring pattern 0 -1))))

(use-package orderless
  :init
  (setq completion-styles '(orderless partial-completion)
        completion-category-defaults nil
        orderless-style-dispatchers '(bsb/ignoring-dispatcher
                                      bsb/initials-dispatcher)))

;;; use embark for context-aware actions

(use-package embark
  :bind
  (("C-." . embark-act)  ;; pick some comfortable binding
   ("M-." . embark-dwim) ;; safe since for code this will call xref

   ("C-h B" . embark-bindings) ;; alternative for `describe-bindings'
   :map vertico-map
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

;;; Consider visual-fill-column-mode and writeroom-mode.
