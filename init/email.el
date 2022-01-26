;;; -*- lexical-binding: t; -*-

;;; Get pass configured.

(use-package pass
  :config
  (setq epa-pinentry-mode 'loopback))

;;; Get SMTP configured.

(setq user-full-name "Brit Butler"
      user-mail-address "brit@kingcons.io"
      mm-default-directory "~/Downloads"
      smtpmail-smtp-server "smtp.migadu.com"
      smtpmail-smtp-service 465
      smtpmail-stream-type 'ssl
      smtpmail-servers-requiring-authorization smtpmail-smtp-server
      message-send-mail-function 'smtpmail-send-it
      message-kill-buffer-on-exit t)

;; Configure mu4e

(defun bsb/make-context (name address folder)
  (let ((smtp-gmail '((smtpmail-smtp-server . "smtp.gmail.com")
                      (smtpmail-stmp-service . 465)
                      (smtpmail-stream-type . ssl)))
        (smtp-migadu '((smtpmail-smtp-server . "smtp.migadu.com")
                       (smtpmail-smtp-service . 587)
                       (smtpmail-stream-type . starttls))))
    (make-mu4e-context :name name
                       :match-func (lambda (msg)
                                     (when msg
                                       (mu4e-message-contact-field-matches msg :to address)))
                       :vars `(,@(if (string-match-p "kingcons.io" address) smtp-migadu smtp-gmail)
                               (user-mail-address . ,address)
                               (mu4e-sent-folder . ,(concat folder "/Sent Mail"))
                               (mu4e-trash-folder . ,(concat folder "/Trash"))))))

(use-package mu4e
  :config
  (setq mu4e-context-policy 'pick-first
        mu4e-compose-context-policy 'ask-if-none
        mu4e-get-mail-command "mbsync -a"
        mu4e-change-filenames-when-moving t)
  (setq mu4e-contexts `(,(bsb/make-context "calendly" "b.butler@calendly.com" "/calendly[Gmail]")
                        ,(bsb/make-context "britton" "britton.s.butler@gmail.com" "/britton[Gmail]")
                        ,(bsb/make-context "redline" "redline6561@gmail.com" "/redline[Gmail]")
                        ,(bsb/make-context "kingcons" "brit@kingcons.io" "/kingcons"))))
