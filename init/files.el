;;; Ensure dired reuses the current buffer

(use-package dired
  :ensure nil
  :init (setq dired-kill-when-opening-new-dired-buffer t))

;;; Use fortune for lambda.txt

(use-package fortune
  :bind (("C-c f" . fortune-message))
  :init (setq fortune-file (concat bsb/config-dir "site-lisp/lambda.txt")))

;;; Add pdf-tools to gracefully handle pdfs.

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page))

;;; And nov.el for epub files

(use-package nov
  :mode (("\\.epub\\'" . nov-mode))
  :init
  (setq nov-text-width 80))
