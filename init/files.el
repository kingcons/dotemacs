;;; Ensure dired reuses the current buffer

(use-package dired
  :ensure nil
  :init (setq dired-kill-when-opening-new-dired-buffer t))

;;; Add pdf-tools to gracefully handle pdfs.

(use-package pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page))
