;;; Use which-key and helpful to explore emacs more gracefully.

(use-package which-key
  :config (which-key-mode))

(use-package helpful
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)))

(use-package keycast
  :bind (("C-c k" . keycast-mode)))

;; TODO: Package marginalia for guix? Update keycast package?
;; (use-package marginalia
;;   :init (marginalia-mode)
