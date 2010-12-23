(defvar libnotify-program "/usr/bin/notify-send")

(defun notify-send (title message)
  (start-process "notify" " notify"
                 libnotify-program "--expire-time=4000" title message))
