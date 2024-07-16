(use-package emms
  :pin gnu
  :config
  (emms-minimalistic)
  (require 'emms-cache)
  (require 'emms-browser)
  (require 'emms-history)
  (require 'emms-info-native)
  (require 'emms-last-played)
  ; TODO: Under consideration
  ; (require 'emms-mode-line)
  ; (require 'emms-playlist-limit)
  (emms-history-load)
  ; To eval on first run only. Expect some lag.
  ; Takes about ~11m for 3600 flacs: 300 tracks/min.
  ; (emms-add-directory-tree "~/Music/")
  (emms-cache 1)
  (add-hook 'emms-player-started-hook #'emms-last-played-update-current)
  (setq emms-player-list '(emms-player-vlc)
        emms-info-functions '(emms-info-native)
        emms-track-initialize-functions #'emms-info-initialize-track
        emms-browser-covers #'emms-browser-cache-thumbnail-async
        emms-source-file-default-directory "~/Music/"))
