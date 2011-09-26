(require 'clojure-mode)

(add-hook 'clojure-mode-hook
          '(lambda ()
             (define-key clojure-mode-map
               "\C-c\C-e" 'lisp-eval-last-sexp)
             (define-key clojure-mode-map
               "\C-x\C-e" 'lisp-eval-last-sexp)))

