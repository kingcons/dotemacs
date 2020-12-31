;; Remove aesthetic cruft
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)

;; Use a nice color scheme
(load-theme 'zenburn t)

;; Use a nice font
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-12"))

;; TODO: emacs-emojify but not with openmoji, maybe twemoji?
