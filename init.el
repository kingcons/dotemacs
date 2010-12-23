(add-to-list 'load-path "~/emacs/site-lisp")

(defun expand-and-load (files)
  (mapcar (lambda (name)
            (load-file (expand-file-name
                        (format "%s/%s.el" "~/emacs/init" name))))
          files))

(expand-and-load '("automode"
                   "clojure"
                   "color-theme"
                   "display"
                   "elisp"
                   "factor"
                   "haskell"
                   "keybindings"
                   "magit"
                   "misc"
                   "modeline"
                   "ocaml"
                   "paredit"
                   "scheme"
                   "slime"
                   "w3m"
                   "whitespace"))

; let's not load chat clients on my servers...
; even though it would be cute to lurk on channels 24 hours a day.
(when (eq window-system 'x)
  (expand-and-load '("notify"
                     "erc"
                     "jabber")))
