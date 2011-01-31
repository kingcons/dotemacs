; Load it up
(add-to-list 'load-path "~/emacs/site-lisp/jabber-mode")
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

; Notifications
(setq jabber-message-alert-same-buffer nil)

; Display
(setq jabber-show-offline-contacts nil
      jabber-roster-line-format " %c %-25n %u %-8s  %S")

(defun stump-jabber-notify (from buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber chat messages via stumpish"
  (let ((name (jabber-jid-displayname from)))
    ; Should read as "Unless an emacs frame is in focus and it's the chatting frame..."
    ; this is closer to correct but behavior is still unpredictable.
    ; TODO: Figure out what (selected-frame) returns in case I'm on a
    ; stumpwm group/virtual desktop with no emacs frames.
    ; Make sure that jabber-alert-message-hooks behaves as we expect.
    (unless (and (selected-frame)
                 (eq (window-frame (get-buffer-window buf t))
                     (selected-frame)))
      (stump-add-notification (format "%s:%s" name text)))))

(add-hook 'jabber-alert-message-hooks 'stump-jabber-notify)

; Misc
(add-hook 'jabber-chat-mode-hook 'goto-address)
