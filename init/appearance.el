;; Remove aesthetic cruft
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

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

(cond ((bsb/font-available-p "DejaVu Sans Mono")
       (bsb/activate-font "DejaVu Sans Mono"))
      ((bsb/font-available-p "Fira Mono")
       (bsb/activate-font "Fira Mono"))
      ((bsb/font-available-p "Liberation Mono")
       (bsb/activate-font "Liberation Mono"))
      ((bsb/font-available-p "Ubuntu Mono")
       (bsb/activate-font "Ubuntu Mono"))
      ((bsb/font-available-p "Hack")
       (bsb/activate-font "Hack")))

;; (pp (seq-filter (lambda (x) (string-match-p "Mono" x))
;;                 (font-family-list)))
