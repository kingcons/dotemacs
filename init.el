(add-to-list 'load-path "~/emacs/site-lisp")

(defun expand-and-load (files)
  (mapcar (lambda (name)
            (load-file (expand-file-name
                        (format "%s/%s.el" "~/emacs/init" name))))
          files))

(expand-and-load '(; make sure all the libraries we know
                   ; and love are installed first
                   "packages"
                   "automode"
                   "browser"
                   "color-theme"
                   "display"
                   "elisp"
                   "c"
                   ;"factor"
                   "haskell"
                   "ido"
                   "keybindings"
                   "magit"
                   "misc"
                   "modeline"
                   "ocaml"
                   "paredit"
                   "pastes"
                   "pgp"
                   "python"
                   "spelling"
                   "stats"
                   "terminal"
                   "tramp"
                   "whitespace"
                   ; Load order actually matters now...
                   "slime"
                   "clojure"
                   "scheme"
                   "notify"
                   "erc"
                   "jabber"))
