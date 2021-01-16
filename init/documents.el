;;; Add pdf-tools to gracefully handle pdfs.

(bsb/use-package! pdf-tools
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page))
