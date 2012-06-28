(require 'paredit)

(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(mapc (lambda (mode)
        (let ((hook (intern (concat (symbol-name mode) "-mode-hook"))))
          (add-hook hook (lambda () (paredit-mode +1)))))
      '(emacs-lisp lisp slime clojure))

;; Stop SLIME's REPL from grabbing DEL,
;; which is annoying when backspacing over a '('
;          (defun override-slime-repl-bindings-with-paredit ()
;            (define-key slime-repl-mode-map
;                (read-kbd-macro paredit-backward-delete-key) nil))
;                (add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)

;; (defun paredit-space-for-delimiter-p (endp delimiter)
;;   ;; If at the buffer limit, don't insert a space.  If there is a word,
;;   ;; symbol, other quote, or non-matching parenthesis delimiter (i.e. a
;;   ;; close when want an open the string or an open when we want to
;;   ;; close the string), do insert a space.
;;   (and (not (if endp (eobp) (bobp)))
;;        (and (not (= (char-before) ?L))
;;             (not (= (char-before (1- (point))) ?#)))
;;        (memq (char-syntax (if endp (char-after) (char-before)))
;;              (list ?w ?_ ?\"
;;                    (let ((matching (matching-paren delimiter)))
;;                      (and matching (char-syntax matching)))))))
