; Load it up
(require 'erc)
; Set some SSL stuff up...
(require 'tls)
(setq tls-program '("openssl s_client -connect %h:%p -no_ssl2 -ign_eof")
      autojoin-channels-alist '((".*\\.freenode.net" "#lisp" "#sbcl" "#concatenative" "#paktahn")
                                ("irc.shoutcast.com" "#nesdev")
                                ("irc.mozilla.org" "#rust")
                                ("ircs.cmgdigital.com" "#all" "#clug" "#team6"))
      erc-autojoin-mode t
      erc-user-full-name "Brit Butler"
      znc-serv "redlinernotes.com"
      znc-port 6561)

; Highlighting and Matches
(setq erc-current-nick-highlight-type 'nick
      erc-pals '("persi" "lpolzer" "xach" "nyef"
                 "antifuchs" "nikodemus" "pkhuong"
                 "slava" "littledan")
      erc-keywords '("\\blunch\\b" "\\bcodereview\\b"
                     "\\bbrit\\b" "\\bredline\\b")
      erc-fools '())

; Logging
(pushnew 'log erc-modules)
(erc-update-modules)
(setq erc-log-channels t
      erc-log-channels-directory "~/Documents/logs/irc"
      erc-log-write-after-send t
      erc-log-write-after-insert t)

; Channel Tracking and Notifications
(setq erc-log-matches-types-alist '((keyword . "ERC Keywords")
                                    (current-nick . "ERC Nick Mentions"))
      erc-track-mode t
      erc-track-exclude-types '("JOIN" "PART" "QUIT" "NICK" "MODE"))

(defun stump-irc-notify (matched-type nick msg)
  "(erc hook) Notify of new IRC messages via stumpish"
  (when (eq matched-type 'current-nick)
    ;; I wish there was a good way to tell what buffer the message was coming from
    ;; but I haven't seen one. Is there a good way to check if I'm *in* that buffer?
    (stump-add-notification
     (format "%s:%s" (car (split-string nick "!")) msg))))

(add-hook 'erc-text-matched-hook 'stump-irc-notify)

(defun irc-home ()
  (interactive)
  (erc-tls :server znc-serv :port znc-port :password znc-userpass)
  (erc-tls :server znc-serv :port znc-port :password moz-userpass)
  (erc-tls :server znc-serv :port znc-port :password efnet-userpass))

(defun start-chat ()
   "Connect to IRC and Jabber accounts."
   (interactive)
   (irc-home)
   (jabber-connect-all))
