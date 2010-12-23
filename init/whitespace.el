(setq-default indent-tabs-mode nil)

(defun untabify-buffer ()
  "Run untabify on the current buffer"
  (interactive)
  (save-excursion (untabify (point-min) (point-max))))

(add-hook 'write-file-hooks 'delete-trailing-whitespace)

(setq whitespace-style '(tabs trailing))

(add-hook 'lisp-mode-hook 'whitespace-mode)
(add-hook 'clojure-mode-hook 'whitespace-mode)
(add-hook 'haskell-mode-hook 'whitespace-mode)
(add-hook 'tuareg-mode-hook 'whitespace-mode)
(add-hook 'factor-mode-hook 'whitespace-mode)
