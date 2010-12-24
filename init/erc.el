; Load it up
(require 'erc)

; Connections/Basics
(setq erc-autojoin-channels-alist '((".*\\.freenode.net" "#lisp" "#sbcl" "#concatenative"))
      erc-nick "redline6561"
      erc-pass "like-i'd-commit-that..."
      erc-user-full-name "Brit Butler"
      erc-autojoin-mode t)
(erc :server "irc.freenode.net" :port 6667 :nick erc-nick :password erc-pass)

; Highlighting and Matches
(setq erc-current-nick-highlight-type 'nick
      erc-pals '("persi" "lpolzer" "xach" "nyef"
                 "antifuchs" "nikodemus" "pkhuong")
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

(defun xosd-irc-notify (matched-type nick msg)
  "(erc hook) Notify of new IRC messages via xosd"
  (when (eq matched-type 'current-nick)
    (xosd-display-message "erc-xosd" (format "Message from %s: %s"
                                             (car (split-string nick "!")) text))))

(add-hook 'erc-text-matched-hook 'xosd-irc-notify)
