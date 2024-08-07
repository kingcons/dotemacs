;;; Ensure dired reuses the current buffer

(use-package dired
  :ensure nil
  :init (setq dired-kill-when-opening-new-dired-buffer t
              dired-recursive-copies 'always
              dired-recursive-deletes 'always))

;;; Use fortune for lambda.txt

(use-package fortune
  :bind (("C-c f" . fortune-message))
  :init (setq fortune-file (concat bsb/config-dir "site-lisp/lambda.txt")))

;;; Add markdown support

(use-package markdown-mode
  :config
  (setq markdown-fontify-code-blocks-natively t))
