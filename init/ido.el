; Interactively Do Things
(require 'ido)
(setq ido-everywhere t)
(setq ido-enable-flex-matching t)
(setq ido-create-new-buffer 'always)
(ido-mode 1)

; Smex, It's ido for M-x!
;(require 'smex)
;(smex-initialize)
;(global-set-key (kbd "M-x") 'smex)
;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

