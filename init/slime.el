; Quicklisp is awesome...but let's manage this ourselves...
(add-to-list 'load-path "~/emacs/site-lisp/slime-clj")
(require 'slime-autoloads)

;; Set implementations and character encoding
; C-u M-x slime will prompt you for what lisp implementation to use.
; M-- M-x slime works too. What's the difference?
(setq slime-lisp-implementations
  '((ccl  ("ccl64" "-K utf-8"))
    (ecl  ("ecl"))
    (sbcl ("sbcl"))))
(setq slime-default-lisp 'sbcl)
(setq inhibit-splash-screen t)
(setq slime-net-coding-system 'utf-8-unix)
(set-language-environment "utf-8")

;;;; What slime modules shall we use? Keep it simple for now...
(slime-setup '(slime-fancy
               slime-tramp
               ; slime-highlight-edits
               ; slime-sprof
               ; slime-indentation
               ; slime-xref-browser
               ; slime-hyperdoc
               ; holy crap there is a lot of stuff in contrib...
               ))

; Change a few keybindings
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (local-unset-key ",")
	    (local-set-key "\M-," 'slime-handle-repl-shortcut)
            (setq slime-complete-symbol*-fancy t)))

;; I've got the HyperSpec locally, why aren't I using it?
(setq common-lisp-hyperspec-root "/home/redline/builds/HyperSpec/")

; Everybody loves Parenscript...
;(load "js-expander.el")

; Misc...
;(setq slime-enable-evaluate-in-emacs t)
