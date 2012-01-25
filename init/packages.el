(when (< emacs-major-version 24)
  (load "~/emacs/site-lisp/package-23.el"))

(require 'package)
(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")
                         ("ELPA" . "http://tromey.com/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
(package-refresh-contents)

(defun activate-packages (names)
  (mapcar (lambda (package)
            (unless (package-installed-p package)
              (package-install package)))
          names))

(activate-packages '(paredit
                     clojure-mode
                     clojurescript-mode
                     elein
                     ipython
                     python-mode
                     python-pylint
                     python-pep8
                     pyflakes
                     flymake
                     flymake-cursor
                     c-eldoc
                     cppcheck
                     tuareg
                     haskell-mode
                     magit
                     magithub
                     gist
                     dpaste
                     lisppaste
                     color-theme
                     color-theme-solarized
                     color-theme-zenburn
                     color-theme-github
                     full-ack
                     browse-kill-ring
                     smex))

;; new goodies to consider:
;; markdown-mode
;; perspectives or workgroups?
;; find-file-in-project?
;; highlight-80+ ... didn't I have something for this, in whitespace.el maybe?

;; what about org and org-magit?
;; notify or notifications?
;; what are we using for: tags, flymake-ish, flyspell, gud/gdb?
