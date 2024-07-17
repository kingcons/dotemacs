;; Remove aesthetic cruft
(menu-bar-mode -1)
(blink-cursor-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

(when (display-graphic-p)
  (setq use-dialog-box nil
        use-file-dialog nil)
  (setq-default fringes-outside-margins t))

;; Scroll as little as needed rather than recentering
(setq scroll-conservatively 32)

;; Display lines and columns when useful
(column-number-mode)
(dolist (mode '(text-mode-hook prog-mode-hook conf-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 1))))
;; But not in org-mode
(add-hook 'org-mode-hook (lambda () (display-line-numbers-mode 0)))

;; Use a simple mode line

(defvar bsb/mode-line-format
  '("   "
    mode-line-buffer-identification "   " mode-line-position
    (vc-mode vc-mode) "   " mode-line-modes mode-line-misc-info
    "   "))

(setq-default mode-line-format bsb/mode-line-format)

;; Use nice themes

(use-package zenburn-theme)

(defvar bsb/color-scheme 'dark)

(defun bsb/init-color-scheme ()
  (cond ((eq bsb/color-scheme 'dark)
         (disable-theme 'modus-operandi)
         (load-theme 'zenburn t))
        ((eq bsb/color-scheme 'light)
         (disable-theme 'zenburn)
         (load-theme 'modus-operandi t))))

(defun bsb/switch-color-scheme ()
  (interactive)
  (setq bsb/color-scheme (if (eq bsb/color-scheme 'light) 'dark 'light))
  (bsb/init-color-scheme))

(bsb/init-color-scheme)

;; Make sure we can hide minor modes where desirable

(use-package delight)

;; Use a nice font
(defun bsb/font-available-p (font-name)
  (find-font (font-spec :name font-name)))

(defvar bsb/default-font-size
  (if bsb/guix-system-p
      "-10"
    "-14"))

(cl-defun bsb/activate-font (font-name &optional (size bsb/default-font-size))
  (let ((font-with-size (concat font-name size)))
    (add-to-list 'default-frame-alist (cons 'font font-with-size))
    (set-frame-font font-with-size)))

(let ((fonts '("Hack"
               "Fira Code"
               "DejaVu Sans Mono"
               "Liberation Mono"
               "IBM Plex Mono"
               "Ubuntu Mono")))
  (cl-dolist (font fonts)
    (when (bsb/font-available-p font)
      (cl-return (bsb/activate-font font)))))

;; (pp (seq-filter (lambda (x) (string-match-p "Mono" x))
;;                 (font-family-list)))
