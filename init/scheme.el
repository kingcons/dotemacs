;; Geiser for Guile
(add-to-list 'load-path "~/emacs/site-lisp/geiser/elisp")
(setq geiser-impl-installed-implementations '(guile))
(require 'geiser)

;; Swank and SLIME for Chicken
(add-to-list 'load-path "~/emacs/site-lisp/swank-chicken")
(autoload 'chicken-slime "chicken-slime" "SWANK backend for Chicken" t)
(setq swank-chicken-path "~/emacs/site-lisp/swank-chicken/swank-chicken.scm")
(add-hook 'scheme-mode-hook
          (lambda ()
            (slime-mode t)))
