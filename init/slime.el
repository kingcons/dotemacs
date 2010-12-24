; Quicklisp is awesome...but let's manage this ourselves...
(add-to-list 'load-path "~/emacs/site-lisp/slime")
(require 'slime-autoloads)
;(require 'slime)
;(setq slime-path "~/emacs/site-lisp/slime")
;(setq slime-backend "~/emacs/site-lisp/slime/swank-loader.lisp")

;; Set implementations and character encoding
; C-u M-x slime will prompt you for what lisp implementation to use.
(setq slime-lisp-implementations
  '((ccl  ("ccl64" "-K utf-8"))
    (ecl  ("ecl"))
    (sbcl ("sbcl"))))
(setq slime-default-lisp 'sbcl)
(setq inhibit-splash-screen t)
(setq slime-net-coding-system 'utf-8-unix)
(set-language-environment "utf-8")

;;;; What slime modules shall we use? Keep it simple for now...
(slime-setup '(slime-fancy))
;; (slime-setup '(slime-asdf
;; 	       slime-c-p-c
;; 	       slime-editing-commands
;; 	       slime-fancy-inspector
;; 	       slime-fontifying-fu
;; 	       slime-fuzzy
;; 	       slime-indentation
;; 	       slime-package-fu
;; 	       slime-references
;; 	       slime-repl
;; 	       ;slime-sbcl-exts
;; 	       slime-scratch
;; 	       ;slime-tramp
;; 	       slime-xref-browser))
;; (setq slime-use-autodoc-mode t)
;; (slime-asdf-init)
;; (slime-fontifying-fu-init)
;; (slime-fuzzy-init)
;; (slime-indentation-init)
;; (slime-scratch-init)
;; (slime-references-init)

; Change a few keybindings
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (local-unset-key ",")
	    (local-set-key "\M-," 'slime-handle-repl-shortcut)
            (setq slime-complete-symbol*-fancy t)))
;(slime-require :swank-listener-hooks)

;; I've got the HyperSpec locally, why aren't I using it?
(setq common-lisp-hyperspec-root "/home/redline/builds/HyperSpec/")

; Everybody loves Parenscript...
;(load "js-expander.el")

; Misc...
;(setq slime-enable-evaluate-in-emacs t)
