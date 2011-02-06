;; Use globally? I've made this mistake in commit messages before...
; (require 'dupwords)
; (eval-after-load "dupwords" '(setq dw-forward-words 5))

(setq-default indent-tabs-mode nil)

(defun untabify-buffer ()
  "Run untabify on the current buffer"
  (interactive)
  (save-excursion (untabify (point-min) (point-max))))

;; FIXME: Either turn this on for everything or for the modes below.
; (add-hook 'find-file-hooks 'untabify-buffer)
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

(setq whitespace-style '(tabs trailing lines-tail)
      whitespace-line-column 80)

(mapc (lambda (mode)
        (let ((hook (intern (concat (symbol-name mode) "-mode-hook"))))
          ;; TODO: Maybe add highlighting of special words like TODO
          ;; and FIXME, etc in these modes.
          ;(add-hook hook 'flyspell-prog-mode)
          (add-hook hook 'whitespace-mode)))
      '(lisp emacs-lisp clojure scheme haskell factor tuareg sh
        python c c++ java php scala javascript nxml LaTeX css))

(setq require-final-newline t)
; (setq next-line-add-newlines nil)
