;; Scala-mode
(add-to-list 'load-path "~/emacs/site-lisp/scala-mode")
(require 'scala-mode-auto)
;; ENSIME
(add-to-list 'load-path "~/emacs/site-lisp/ensime")
(require 'ensime)

(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
