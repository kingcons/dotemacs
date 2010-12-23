(require 'w3m)

(defun scroll-up-one-line ()
  (interactive)
  (scroll-up 1))

(defun scroll-down-one-line ()
  (interactive)
  (scroll-down 1))

(setq browse-url-generic-program "chromium")

(defun chrome (url &optional new-window)
  (interactive (browse-url-interactive-arg "URL: "))
  (browse-url-generic url new-window))

(defun chrome-here ()
  (interactive)
  (let ((url (browse-url-url-at-point)))
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
