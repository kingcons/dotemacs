;;;; In *most* regrettable fashion, there is still a great divide
;;;; between Common Lisp swank/slime and every other implementation.
;;;; Will these atrocities ever end?
(add-to-list 'load-path "~/emacs/site-lisp/slime")

; Quicklisp is awesome...but let's manage this ourselves...
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
(setq font-lock-verbose nil)
(set-language-environment "utf-8")
(eval-after-load 'slime '(setq slime-protocol-version 'ignore))

;;;; What slime modules shall we use? Keep it simple for now...
(slime-setup '(slime-fancy
               slime-tramp
               slime-asdf
               ; slime-highlight-edits
               ; slime-sprof
               ; slime-indentation
               ; slime-xref-browser
               ; slime-hyperdoc
               ; holy crap there is a lot of stuff in contrib...
               ))

(defun slime-find-current-system ()
  (slime-eval `(cl:let ((cl:*package*
                         (cl:find-package ,(slime-current-package))))
                       (swank::find-current-system))))

(defun slime-test-current-system ()
  (interactive)
  (slime-oos (slime-find-current-system) "TEST-OP"))

; Change a few keybindings
(setq slime-complete-symbol-function 'slime-fuzzy-complete-symbol)
(add-hook 'slime-repl-mode-hook
	  (lambda ()
	    (local-unset-key ",")
	    (local-set-key "\M-," 'slime-handle-repl-shortcut)
            (local-set-key (kbd "C-c t") 'slime-test-current-system)
            (setq slime-complete-symbol*-fancy t)))

;; I've got the HyperSpec locally, why aren't I using it?
(setq common-lisp-hyperspec-root "/home/redline/builds/HyperSpec/")

;; Old SLIME code removed by Helmut on 2008-03-14. I use it to run
;; multiple inferior-lisps for different langs (i.e. clj, scm, cl) concurrently.
(defun slime-find-connection-by-name (name)
  (find name slime-net-processes
        :test #'string= :key #'slime-connection-name))

(defun slime-select-connection-by-ext (extension-name)
  `((string= type ,(first extension-name))
    (setq slime-buffer-connection
          (slime-find-connection-by-name ,(second extension-name)))))

(setq slime-connections-map '(("lisp" "sbcl")
                              ("asd" "sbcl")
                              ("clj" "clojure")))

(defmacro assign-correct-connection ()
  `(let ((type ,(file-name-extension (buffer-name))))
     (cond ,@(mapcar #'slime-select-connection-by-ext slime-connections-map))))

(add-hook 'slime-mode-hook (lambda () (assign-correct-connection)))

; Everybody loves Parenscript...
;(load "js-expander.el")

; Misc...
;(setq slime-enable-evaluate-in-emacs t)
