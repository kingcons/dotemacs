(require 'clojure-mode)

(remove-hook 'clojure-mode-hook 'clojure-enable-slime)
(add-hook 'clojure-mode-hook 'nrepl-eldoc-enable-in-current-buffer)
(setq nrepl-popup-stacktraces nil)
