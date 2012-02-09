(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)

(setq multi-term-program "/bin/bash")

(add-to-list 'term-bind-key-alist '("C-y" . term-paste))
(add-to-list 'term-bind-key-alist '("C-<backspace>" . term-send-backward-kill-word))
(add-to-list 'term-bind-key-alist '("M-<backspace>" . term-send-backward-kill-word))

(global-set-key (kbd "C-c t") 'multi-term)
(global-set-key (kbd "C-<tab>") 'multi-term-next)

