;; Use magit for git magic, obviously.

(bsb/use-package! magit
  :bind (("C-x g" . magit-status)
         ("C-c g" . magit-file-dispatch)))

;; TODO: Add forge for github integration?
