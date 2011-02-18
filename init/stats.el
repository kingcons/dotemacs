(defvar key-stats-commands ())

(defun key-stats-record-command ()
  (when (stringp (this-command-keys))
    (let* ((keys (this-command-keys))
           (keys-list (assoc major-mode key-stats-commands))
           (command (assoc keys (cdr keys-list))))
      (cond (command
             (incf (cdr command)))
            (keys-list
             (push (cons keys 1) (cdr keys-list)))
            (t
             (push (list major-mode (cons keys 1))
                   key-stats-commands))))))

(defun key-stats-print-keys (keys)
  (insert (symbol-name (car keys)))
  (newline)
  (loop for (key . count) in (sort* (copy-list (cdr keys))
                                    #'> :key #'cdr)
        do (insert (format "  %-7s  %d\n" (key-description key)
                           count))))

(defun key-stats ()
  (interactive)
  (with-current-buffer (get-buffer-create "*key-stats*")
    (erase-buffer)
    (mapc 'key-stats-print-keys key-stats-commands)
    (goto-char (point-min))
    (pop-to-buffer (current-buffer))))

(add-hook 'pre-command-hook 'key-stats-record-command)
