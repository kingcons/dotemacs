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

(defun bsb/go-town ()
  ;; Relies on a LocalForward rule in ~/.ssh/config for town
  (interactive)
  (async-shell-command "ssh -N town" "*ssh-tilde-town*")
  (sleep-for 1)
  (erc-tls :server "localhost"
           :port 6697
           :nick "kingcons"
           :password (password-store-get "irc/tildetown")))

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
  :unless (eq system-type 'darwin)
  :load-path "/usr/share/emacs/site-lisp/elpa/mu4e-1.10.8/"
  :bind (("s-e" . mu4e))
  :config
  (setq mu4e-context-policy 'pick-first
        mu4e-compose-context-policy 'ask-if-none
        mu4e-get-mail-command (format "mbsync -a -c %s"
                                      (expand-file-name ".mbsyncrc" bsb/config-dir))
        mu4e-change-filenames-when-moving t)
  (setq mu4e-contexts `(,(bsb/make-context "britton" "britton.s.butler@gmail.com" "/britton[Gmail]")
                        ,(bsb/make-context "kingcons" "brit@kingcons.io" "/kingcons"))))
