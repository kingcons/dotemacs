(add-to-list 'load-path "~/emacs/site-lisp")

(defun expand-and-load (files)
  (mapcar (lambda (name)
            (load-file (expand-file-name
                        (format "%s/%s.el" "~/emacs/init" name))))
          files))

(expand-and-load '("automode"
                   "browser"
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
                   "pgp"
                   "scala"
                   "whitespace"
                   ; Load order actually matters now...
                   "slime"
                   "clojure"
                   "scheme"
                   "notify"
                   "erc"
                   "jabber"))

(defun start-chat ()
   "Connect to IRC and Jabber accounts."
   (interactive)
   (erc :server "irc.freenode.net" :port 6667 :nick erc-nick :password erc-pass)
   (jabber-connect-all))
