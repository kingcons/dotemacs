(add-to-list 'load-path "~/emacs/site-lisp/magit")
(require 'magit)

(set-face-attribute 'magit-diff-add nil :foreground "Green")
(set-face-attribute 'magit-diff-del nil :foreground "brightred")
(set-face-attribute 'magit-item-highlight nil :background "gray10")

(defun magit-amend ()
  (interactive)
  (magit-log-edit-toggle-amending))

(defun do-commit ()
  (interactive)
  (beginning-of-buffer)
  (replace-regexp "^#" " #")
  (magit-log-edit-commit))

(define-key magit-log-edit-mode-map (kbd "C-c C-c") 'do-commit)
