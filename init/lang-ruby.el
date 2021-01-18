;; C-c , v to run a spec
(bsb/use-package! rspec-mode
  :mode ("*spec.rb" . rspec-mode))

(bsb/use-package! robe
  :bind (:map robe-mode-map
              ("C-c C-s" . robe-start))
  :hook ((ruby-mode . robe-mode))
  :config
  (push 'company-robe company-backends)
  (defun bsb/autostart-rails (&optional force)
    (unless (get-buffer "*rails*")
      (call-interactively 'inf-ruby-console-rails)))
  (add-function :before (symbol-function 'robe-start) #'bsb/autostart-rails))
