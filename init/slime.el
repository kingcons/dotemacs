;; Who doesn't love Quicklisp?
(load (expand-file-name "/media/redlinux/home/redline/Desktop/quicklisp/slime-helper.el"))

; C-u M-x slime will prompt you for what lisp implementation to use.
(setq slime-lisp-implementations
  '((ccl  ("ccl64" "-K utf-8"))
    (ecl  ("ecl"))
    (sbcl ("sbcl"))
    (sbcl-git ("/home/redline/builds/clbuild-dev/clbuild" "lisp"))))
(setq slime-default-lisp 'sbcl)
(setq inhibit-splash-screen t)
(setq slime-net-coding-system 'utf-8-unix)
(set-language-environment "utf-8")

(require 'slime)
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(setq slime-use-autodoc-mode t)
(slime-setup '(slime-asdf
	       slime-c-p-c
	       slime-editing-commands
	       slime-fancy-inspector
	       slime-fontifying-fu
	       slime-fuzzy
	       slime-indentation
	       slime-package-fu
	       slime-references
	       slime-repl
	       ;slime-sbcl-exts
	       slime-scratch
	       ;slime-tramp
	       slime-xref-browser))
(slime-asdf-init)
(slime-fontifying-fu-init)
(slime-fuzzy-init)
(slime-indentation-init)
(slime-scratch-init)
(slime-references-init)
(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (local-unset-key ",")
	    (local-set-key "\M-," 'slime-handle-repl-shortcut)
            (setq slime-complete-symbol*-fancy t)))
(slime-require :swank-listener-hooks)

;; I've got the HyperSpec locally, why aren't I using it?
(setq common-lisp-hyperspec-root "/home/redline/builds/HyperSpec/")

(load "js-expander.el")

;(setq slime-enable-evaluate-in-emacs t)
