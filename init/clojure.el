(add-to-list 'load-path "/usr/share/emacs/site-lisp/clojure-mode")
(require 'clojure-mode)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/swank-clojure")
(require 'swank-clojure)

(add-hook 'clojure-mode-hook
          '(lambda ()
             (define-key clojure-mode-map
               "\C-c\C-e" 'lisp-eval-last-sexp)
             (define-key clojure-mode-map
               "\C-x\C-e" 'lisp-eval-last-sexp)))

(eval-after-load "slime"
  `(progn
     (require 'assoc)
     (setq swank-clojure-classpath
           (list "/usr/share/clojure/clojure.jar"
                 "/usr/share/clojure/clojure-contrib.jar"
                 "/usr/share/emacs/site-lisp/swank-clojure/src"))
     (aput 'slime-lisp-implementations 'clojure
           (list (swank-clojure-cmd) :init 'swank-clojure-init))))
