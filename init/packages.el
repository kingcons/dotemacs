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
                     nrepl
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
                     lua-mode
                     magit
                     gist
                     dpaste
                     lisppaste
                     refheap
                     color-theme
                     color-theme-solarized
                     color-theme-zenburn
                     color-theme-github
                     full-ack
                     browse-kill-ring
                     smex
                     undo-tree
                     regex-tool
                     multi-term
                     markdown-mode))

;; can't wait for emacs 24 + vc-annotate
;; new goodies to consider:
;; perspectives or workgroups?
;; find-file-in-project?
;; highlight-80+ ... didn't I have something for this, in whitespace.el maybe?

;; what about org and org-magit, org-pomodoro, etc?
;; notify or notifications?
;; what are we using for: tags, flyspell, gud/gdb?
