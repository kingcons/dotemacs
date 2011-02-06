;; Htmlize, just because it's handy
(load "htmlize")

;; http://www.splode.com/~friedman/software/emacs-lisp/src/motion-fns.el
(defun goto-longest-line ()
  "Go to longest line in buffer."
  (interactive)
  (let ((longest-line 0)
        (line 0)
        (length 0))
    (save-excursion
      (goto-char (point-min))
      (end-of-line)
      (setq length (current-column))
      (setq longest-line 0)
      (while (zerop (forward-line 1))
        (setq line (1+ line))
        (end-of-line)
        (cond ((> (current-column) length)
               (setq length (current-column))
               (setq longest-line line)))))
    (goto-line (1+ longest-line))))

;; Answer y or n instead of yes or no at minibar prompts.
; (defalias 'yes-or-no-p 'y-or-n-p)

;; Change C-x C-b behavior so it uses bs; shows only interesting buffers.
; (global-set-key "\C-x\C-b" 'bs-show)
