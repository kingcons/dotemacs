;;; -*- lexical-binding: t; -*-

;;; Get pass configured.

(use-package pass
  :config
  (setq epa-pinentry-mode 'loopback))

;;; Get SMTP configured.

(setq user-full-name "Brit Butler"
      user-mail-address "brit@kingcons.io"
      mm-default-directory "~/Downloads"
      message-kill-buffer-on-exit t
      message-send-mail-function 'smtpmail-send-it
      smtpmail-smtp-service 465
      smtpmail-stream-type 'ssl
      smtpmail-servers-requiring-authorization "smtp.migadu.com")

;;;  Get ERC configured while we're doing e-things.

(defun bsb/go-liberachat ()
  (interactive)
  (erc-tls :server "irc.libera.chat"
           :port 6697
           :nick "kingcons"))

(global-set-key (kbd "s-i") 'bsb/go-liberachat)

;; Configure mu4e

(defun bsb/make-context (name address folder)
  (let ((smtp-gmail '(smtpmail-smtp-server . "smtp.gmail.com"))
        (smtp-migadu '(smtpmail-smtp-server . "smtp.migadu.com")))
    (make-mu4e-context :name name
                       :match-func (lambda (msg)
                                     (when msg
                                       (mu4e-message-contact-field-matches msg :to address)))
                       :vars `(,(if (string-match-p "kingcons.io" address) smtp-migadu smtp-gmail)
                               (user-mail-address . ,address)
                               (mu4e-sent-folder . ,(concat folder "/Sent Mail"))
                               (mu4e-trash-folder . ,(concat folder "/Trash"))))))

(unless (eq system-type 'darwin)
  (use-package mu4e
    :bind (("s-e" . mu4e))
    :config
    (setq mu4e-context-policy 'pick-first
          mu4e-compose-context-policy 'ask-if-none
          mu4e-get-mail-command "mbsync -a"
          mu4e-change-filenames-when-moving t)
    (setq mu4e-contexts `(,(bsb/make-context "calendly" "b.butler@calendly.com" "/calendly[Gmail]")
                          ,(bsb/make-context "britton" "britton.s.butler@gmail.com" "/britton[Gmail]")
                          ,(bsb/make-context "redline" "redline6561@gmail.com" "/redline[Gmail]")
                          ,(bsb/make-context "kingcons" "brit@kingcons.io" "/kingcons")))))
