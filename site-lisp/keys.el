;; keys.el

(provide 'keys)

(defmacro with-new-buffer (name &rest body)
  `(with-current-buffer (get-buffer-create ,name)
     (setf buffer-read-only nil)
     (erase-buffer)
     (switch-to-buffer-other-window ,name)
     (prog1
         (progn
           ,@body)
       (setf buffer-read-only t))))

(defun keys ()
  (interactive)
  (flet ((get-bindings (prefix)
                       (loop for c across "abcdefghijklmnopqrstuvwxyz1234567890-="
                             collect (let ((key (format "%s%c" prefix c)))
                                       (list key (or (minor-mode-key-binding (read-kbd-macro key))
                                                     (global-key-binding (read-kbd-macro key))))))))
    (let ((bindings (nconc (get-bindings "C-x C-")
                           (list nil)
                           (get-bindings "C-x ")
                           (list nil)
                           (get-bindings "C-c C-")
                           (list nil)
                           (get-bindings "C-c "))))
      (with-new-buffer
       "*global-keybindings*"
       (loop for binding in bindings
             do (progn
                  (when binding
                    (destructuring-bind (key-sequence function) binding
                      (insert (format "%s" key-sequence))
                      (when function
                        (let ((start (point)))
                          (insert (format "  %s" function))
                          (when (symbolp function)
                            (make-text-button (+ start 2) (point)
                                              'type 'help-function-def
                                              'help-args
                                              (list
                                               function
                                               (find-lisp-object-file-name
                                                function (symbol-function function)))))))))
                  (insert (format "\n"))))
       (view-mode)
       (beginning-of-buffer)))))
