(use-package ruby-mode
  :after eglot
  :ensure nil
  :hook (ruby-mode . eglot-ensure)
  :init
  (setq ruby-insert-encoding-magic-comment nil)
  (add-to-list 'eglot-server-programs
               '(ruby-mode . ("bundle" "exec" "solargraph" "socket" "--port" :autoport)))
  :config
  (subword-mode 1))

;; C-c , v to run a spec
(use-package rspec-mode
  :mode ("*spec.rb" . rspec-mode))
