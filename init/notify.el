(defun xosd-display-message (process-name message &key
                            (position "top") (alignment "center")
                            (duration 10) (font "-*-courier-*-*-*-*-24"))
  "Displays a message via xosd."
  (let ((process-connection-type nil))
    (start-process process-name nil "osd_cat"
                   "-p" position "-A" alignment
                   "-f" font "-d" duration)
    (process-send-string process-name message)
    (process-send-eof process-name)))
