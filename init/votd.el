(defvar bsb/vinyl-collection
  (with-current-buffer (find-file-noselect (bsb/init-file "records" "dat"))
    (goto-char (point-min))
    (read (current-buffer))))

(defun bsb/discogs-search (artist album)
  (let* ((token (password-store-get "discogs/kingcons"))
         (auth-header (format "Discogs token=%s" token))
         (url-request-extra-headers `(("Authorization" . ,auth-header)))
         (base-url "https://api.discogs.com/")
         (base-params "?type=release&format=vinyl")
         (params (format "%s&artist=%s&release_title=%s" base-params artist album))
         (request-url (format "%s/database/search?%s" base-url params)))
    (with-current-buffer
        (url-retrieve-synchronously request-url)
      (goto-char (point-min))
      (let ((data (when (re-search-forward "\r?\n\r?\n" nil t)
                    (json-read))))
        (kill-buffer (current-buffer))
        data))))

(defun bsb/show-cover-art (response)
  (cl-labels ((cover-art (x) (cdr (assoc 'cover_image x)))
              (blank-art? (x) (string-match-p "spacer.gif" (cover-art x))))
    (let* ((results (cdr (assoc 'results response)))
           (record (car (seq-remove #'blank-art? results))))
      (if (null record)
          (message "No matching album found!")
        (let ((cover-art-url (cover-art record)))
          (browse-web cover-art-url)
          (message (format "Now Playing: %s" (cdr (assoc 'title record)))))))))

(defun bsb/filter-vinyl (attribute value)
  (let ((results (seq-copy bsb/vinyl-collection)))
    (cl-flet ((match? (plist) (string= (plist-get plist attribute) value)))
      (seq-filter #'match? results))))

(defun bsb/choose-record (attribute value)
  (let ((candidates (bsb/filter-vinyl attribute value)))
    (bsb/show-random-album candidates)))

(defun bsb/show-random-album (candidates)
  (let* ((record (seq-random-elt candidates))
         (artist (plist-get record :artist))
         (album (plist-get record :album))
         (response (bsb/discogs-search artist album)))
    (message "Searching for %s - %s" artist album)
    (bsb/show-cover-art response)))

(defun bsb/gimme-genre (genre)
  (interactive "sWhat genre? ")
  (bsb/choose-record :genre genre))

(defun bsb/gimme-techno ()
  (interactive)
  (bsb/choose-record :genre "Techno"))

(global-set-key (kbd "s-g") 'bsb/gimme-genre)
(global-set-key (kbd "s-n") 'bsb/gimme-techno)
