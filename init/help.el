;;; Use which-key and marginalia to learn emacs more easily.

(use-package which-key
  :config (which-key-mode))

(use-package marginalia
  :bind (:map minibuffer-local-map
              ("C-M-a" . marginalia-cycle))
  :init
  (marginalia-mode)
  (advice-add #'marginalia-cycle
              :after (lambda ()
                       (when (bound-and-true-p selectrum-mode)
                         (selectrum-exhibit)))))

;; Use Keycast to teach others more about emacs
(use-package keycast
  :bind (("C-c k" . keycast-mode)))

;; Use helpful to get more details when exploring.
(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)))
