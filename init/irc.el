;;;  Get ERC configured.

(defun go-liberachat ()
  (interactive)
  (erc-tls :server "irc.libera.chat"
           :port 6697
           :nick "kingcons"))

(global-set-key (kbd "s-i") 'go-liberachat)
