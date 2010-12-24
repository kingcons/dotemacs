; Load it up
(require 'jabber)

; Connections/Basics
(setq jabber-account-list '(("redline6561@gmail.com"
                             (:network-server . "talk.google.com")
                             (:connection-type . ssl)
                             (:password . "oh-snap-it's-on-github-now!"))
                            ("redline6561@chat.facebook.com"
                             (:network-server . "chat.facebook.com")
                             (:connection-type . network)
                             (:password . "yeah-right!")
                             (:disabled . t)))
      jabber-nickname "Brit Butler")

; Logging
(setq jabber-history-enabled t
      jabber-use-global-history nil
      jabber-history-dir "~/docs/logs/jabber")

;Notifications
(setq jabber-message-alert-same-buffer nil)

(defun xosd-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via xosd"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (xosd-display-message "jabber-xosd" (format "Message from %s: %s"
                                                (jabber-jid-displayname from) text))))

(add-hook 'jabber-alert-message-hooks 'xosd-jabber-notify)

; Misc
(add-hook 'jabber-chat-mode-hook 'goto-address)
