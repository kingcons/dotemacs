;; Support managing packages with guix if possible.

(when bsb/guix-system-p
  (bsb/use-package! guix
    :bind (("C-c p" . guix))))
