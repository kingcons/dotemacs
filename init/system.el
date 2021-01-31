;; Support managing packages with guix if possible.

(when bsb/guix-system-p
  (use-package guix
    :bind (("s-p" . guix))))
