;;;  Get ERC configured.

(defun go-freenode ()
  (interactive)
  (erc-tls :server "kingcons.io"
           :port 6697
           :nick "kingcons"
           :password (password-store-get "znc-freenode")))

(global-set-key (kbd "s-i") 'go-freenode)
