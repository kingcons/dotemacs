;;; Get SMTP configured.

(setq user-full-name "Brit Butler"
      user-mail-address "brit@kingcons.io"
      mm-default-directory "~/Downloads"
      smtpmail-smtp-server "smtp.migadu.com"
      smtpmail-smtp-service 587
      smtpmail-stream-type 'starttls
      smtpmail-servers-requiring-authorization smtpmail-smtp-server
      message-send-mail-function 'smtpmail-send-it
      message-kill-buffer-on-exit t)
