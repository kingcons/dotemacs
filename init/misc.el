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

;; Clone of Vim's Undo Tree
(require 'undo-tree)
; C-x u to invoke.

;; Answer y or n instead of yes or no at minibar prompts.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Get rid of the <2> with duplicate file names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

; Fix copy-paste between emacs and other x programs
(setq x-select-enable-clipboard t)
(when (functionp 'x-cut-buffer-or-selection-value)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))

; no bell
(setq ring-bell-function 'ignore)

; Highlight matching parens
(show-paren-mode t)

;; Make browsing the kill ring easy
(global-set-key (kbd "C-c k") 'browse-kill-ring)

(defun flip-this ()
  (interactive)
  (insert "(╯°□°）╯︵ ┻━┻) "))

(global-set-key (kbd "C-c f t") 'flip-this)

;; Change C-x C-b behavior so it uses bs; shows only interesting buffers.
; (global-set-key "\C-x\C-b" 'bs-show)

;; Taking advice from Yegge...
;; (defun backward-kill-word-or-kill-region (&optional arg)
;;   (interactive "p")
;;   (if (region-active-p)
;;        (kill-region (region-beginning) (region-end))
;;      (backward-kill-word arg)))
;; (global-set-key (kbd "C-w") 'backward-kill-word-or-kill-region)

;; Who wants to use external shells?
;; (defun eshell-goto-current-dir (&optional arg)
;;   (interactive "P")
;;   (let ((dir default-directory))
;;     (eshell arg)
;;     (eshell/cd dir)))
;; And a global keybinding for this... C-c s?
