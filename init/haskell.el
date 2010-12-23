(add-to-list 'load-path "/usr/share/emacs/site-lisp/haskell-mode")
(require 'haskell-mode)

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

(require 'inf-haskell)
