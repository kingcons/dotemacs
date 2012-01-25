;; pdb setup
(setq pdb-path "/usr/bin/pdb")
(setq py-python-command "python")

(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline pdb-path
	 		    (file-name-nondirectory buffer-file-name)))))

;; Modes setup and loading
(autoload 'python-mode "python-mode" "Python Mode." t)

(require 'python-pylint)
(require 'python-pep8)
(require 'compile)
(require 'ipython)
(require 'flymake-cursor)

(add-to-list 'interpreter-mode-alist '("ipython" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; IPython and PDB inserts...
(defun insert-ipython-shell-call ()
  (interactive)
  (insert "import IPython; IPython.embed()"))

(defun insert-pdb-call ()
  (interactive)
  (insert "import pdb; pdb.set_trace()"))

;; Keymap modifications
(define-key py-mode-map (kbd "C-M-k") 'py-beginning-of-def-or-class)
(define-key py-mode-map (kbd "C-M-j") 'py-end-of-def-or-class)
(define-key py-mode-map (kbd "C-M-d") 'pdb)
(define-key py-mode-map (kbd "<f1>") 'pylint)
(define-key py-mode-map (kbd "<f2>") 'pep8)
(define-key py-mode-map (kbd "C-c C-f") 'flymake-goto-next-error)
(define-key py-mode-map (kbd "C-x i") 'insert-ipython-shell-call)
(define-key py-mode-map (kbd "C-x d") 'insert-pdb-call)
(define-key py-mode-map [(control return)] nil)

;; PYFLAKES!
(when (load "flymake" t)
  ;; Create a copy of buffer to run flymake on
  (defun flymake-pylint-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
		       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))

      (list "pyflakes" (list local-file))))
  ;; Ensure this is run before flymake on python files
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pylint-init)))

;; Use flymake but not on non-file buffers
(add-hook 'python-mode-hook
          (lambda ()
            (unless (eq buffer-file-name nil)
              (flymake-mode 1))))
