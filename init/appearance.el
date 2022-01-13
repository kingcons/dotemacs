;; Remove aesthetic cruft
(menu-bar-mode -1)
(when (display-graphic-p)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (horizontal-scroll-bar-mode -1))

;; Scroll as little as needed rather than recentering
(setq scroll-conservatively 32)

;; Display lines and columns when useful
(column-number-mode)
(dolist (mode '(text-mode-hook prog-mode-hook conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))
;; But not in org-mode
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0)))

;; Use a nice color scheme
(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

;; Use a nice font
(defun bsb/font-available-p (font-name)
  (find-font (font-spec :name font-name)))

(defun bsb/activate-font (font-name)
  (let ((font-with-size (concat font-name "-12")))
    (add-to-list 'default-frame-alist (cons 'font font-with-size))
    (set-frame-font font-with-size)))

(let ((fonts '("IBM Plex Mono"
               "DejaVu Sans Mono"
               "Fira Mono"
               "Liberation Mono"
               "Ubuntu Mono"
               "Hack")))
  (cl-dolist (font fonts)
    (when (bsb/font-available-p font)
      (cl-return (bsb/activate-font font)))))

;; (pp (seq-filter (lambda (x) (string-match-p "Mono" x))
;;                 (font-family-list)))
