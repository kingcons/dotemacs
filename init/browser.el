(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "conkeror")

(defun conkeror (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (browse-url-generic url new-window))

(defun chrome (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (let ((browse-url-generic-program "chromium"))
    (browse-url-generic url new-window)))

(defun chrome-here ()
  (interactive)
  (let ((url (browse-url-url-at-point))
        (browse-url-generic-program "chromium"))
    (if url
        (browse-url-generic url)
      (error "No URL found"))))

(defun firefox-here ()
  (interactive)
  (let ((url (browse-url-url-at-point))
        (browse-url-generic-program "firefox"))
    (if url
        (browse-url-generic url)
      (error "No URL found"))))
