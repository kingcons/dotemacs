;; Not working...hmm...
;; (defun xosd-display-message (process-name message)
;;   "Displays a message via xosd."
;;   (start-process process-name nil "osd_cat"
;;                    "-p" "top" "-A" "right" "-d" "10")
;;   (process-send-string process-name message))

;; Who cares? Let's use stumpish!
(defun stump-add-notification (message)
  "Uses start-process and stumpish to send a notification to stump."
  (start-process "stump-notify" "stump-notify"
                 "stumpish" "notifications-add" message))

;; TODO: Maybe we should hook into erc-send and jabber-send so I'm not
;; always resetting my message list? Or a hook for when I return to the
;; buffers at all. Is there such a hook?
(defun stump-clear-notifications ()
  "For after I've returned to IM/IRC."
  (start-process "stump-notify" "stump-notify"
                 "stumpish" "notifications-reset"))
