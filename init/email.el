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
      smtpmail-stream-type 'ssl
      smtpmail-smtp-service 465
      smtpmail-servers-requiring-authorization "smtp.migadu.com")

;;;  Get ERC configured while we're doing e-things.

(defun bsb/go-libera ()
  (interactive)
  (erc-tls :server "irc.libera.chat"
           :port 6697
           :nick "kingcons"))

(defun bsb/go-twitch ()
  (interactive)
  (erc-tls :server "irc.chat.twitch.tv"
           :port 6697
           :nick "king_cons"
           :password (password-store-get "twitch/king_cons")))

(global-set-key (kbd "s-l") 'bsb/go-libera)
(global-set-key (kbd "s-i") 'bsb/go-twitch)

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
                               (smtpmail-smtp-user . ,address)
                               (mu4e-sent-folder . ,(concat folder "/Sent Mail"))
                               (mu4e-trash-folder . ,(concat folder "/Trash"))))))

(use-package mu4e
  :ensure nil
  :if (eq system-type 'darwin)
  ;; KLUDGE: This can be removed when I use emacs28 from apt.
  :load-path "/usr/share/emacs/site-lisp/mu4e/"
  :bind (("s-e" . mu4e))
  :config
  (setq mu4e-context-policy 'pick-first
        mu4e-compose-context-policy 'ask-if-none
        mu4e-get-mail-command "mbsync -a"
        mu4e-change-filenames-when-moving t)
  (setq mu4e-contexts `(,(bsb/make-context "calendly" "b.butler@calendly.com" "/calendly[Gmail]")
                        ,(bsb/make-context "britton" "britton.s.butler@gmail.com" "/britton[Gmail]")
                        ,(bsb/make-context "redline" "redline6561@gmail.com" "/redline[Gmail]")
                        ,(bsb/make-context "kingcons" "brit@kingcons.io" "/kingcons"))))
