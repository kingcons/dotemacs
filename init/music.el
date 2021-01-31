(use-package mpdel
  :init
  (unbind-key "s-m" global-map)
  (setq libmpdel-hostname "raspberrypi.local")
  (setq mpdel-prefix-key (kbd "s-m"))
  :config
  (mpdel-mode))
