; Load it up
(require 'erc)
; Set some SSL stuff up...
(require 'tls)
(setq tls-program '("gnutls-cli --priority secure256 -p %p %h")
      autojoin-channels-alist '((".*\\.freenode.net" "#lisp" "#sbcl" "#concatenative" "#paktahn")
                                ("ircs.cmgdigital.com" "#all" "#clug" "#team6"))
      erc-autojoin-mode t
      erc-user-full-name "Brit Butler"
      znc-userpass "yeahright!:tryagainjerks"
      cmg-userpass "believe:everythingyouread"
      znc-serv "redlinernotes.com"
      znc-port 6561)

; Highlighting and Matches
(setq erc-current-nick-highlight-type 'nick
      erc-pals '("persi" "lpolzer" "xach" "nyef"
                 "antifuchs" "nikodemus" "pkhuong"
                 "slava" "littledan")
      erc-keywords '("\\blunch\\b" "\\bcodereview\\b")
      erc-fools '())

; Logging
(pushnew 'log erc-modules)
(erc-update-modules)
(setq erc-log-channels t
      erc-log-channels-directory "~/docs/logs/irc"
      erc-log-write-after-send t
      erc-log-write-after-insert t)

; Channel Tracking and Notifications
(setq erc-log-matches-types-alist '((keyword . "ERC Keywords")
                                    (current-nick . "ERC Nick Mentions"))
      erc-track-mode t
      erc-track-exclude-types '("JOIN" "PART" "QUIT" "NICK" "MODE"))

(defun stump-irc-notify (matched-type nick msg)
  "(erc hook) Notify of new IRC messages via stumpish"
  (when (and (not (eq (window-frame (selected-window))
                      ; KLUDGE: This is a nasty hardcoding hack.
                      ; It works based on my use case but it ain't good!
                      ; An alternative would be to get the frame or list of frames
                      ; with erc buffers and use memq to check...
                      (window-frame (get-buffer-window "#lisp" t))))
             (eq matched-type 'current-nick))
    (stump-add-notification
     (format "%s:%s" (car (split-string nick "!")) text))))

;; This is temporarily disabled as stump-irc-notify was passing nil as an
;; argument to window-live-p further down the call chain and the beeping and
;; errors are annoying as hell. The nofitications code needs a good working
;; over at some point anyway. At least jabber notifications half work.
; (add-hook 'erc-text-matched-hook 'stump-irc-notify)

(defun irc-work ()
  (interactive)
  (erc-tls :server znc-serv :port znc-port :password cmg-userpass))

(defun irc-home ()
  (interactive)
  (erc-tls :server znc-serv :port znc-port :password znc-userpass))

(defun start-chat ()
   "Connect to IRC and Jabber accounts."
   (interactive)
   (erc-tls :server znc-serv :port znc-port :password znc-userpass)
   (erc-tls :server znc-serv :port znc-port :password cmg-userpass)
   (jabber-connect-all))
