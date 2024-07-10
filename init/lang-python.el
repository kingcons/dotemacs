(use-package python
  :config
  ;; Live that container life. Based on 2metz.fr's blog post.
  (setq eglot-withhold-process-id t)
  (with-eval-after-load 'eglot
    (add-to-list 'eglot-server-programs
                 '(python-mode . ("~/projects/work/investnext/nextdev" "lsp")))))

(use-package python-black
  :config (setq python-black-command "~/projects/work/investnext/nextdev black")
  :hook (python-mode . python-black-on-save-mode-enable-dwim))

