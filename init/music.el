(use-package emms
  :pin gnu
  :config
  (emms-minimalistic)
  (require 'emms-cache)
  (require 'emms-browser)
  (require 'emms-history)
  (require 'emms-mode-line)
  (require 'emms-info-native)
  (require 'emms-last-played)
  (emms-history-load)
  ; To eval on first run only. Expect some lag.
  ; Takes about ~11m for 3600 flacs: 300 tracks/min.
  ; Worth running an explicit (emms-cache-save) after just to be sure.
  ; (emms-add-directory-tree "~/Music/")
  ; TODO: Boy would it be nice if EMMS synced when new dirs are added.
  (emms-cache 1)
  (emms-mode-line-enable)
  (add-hook 'emms-player-started-hook #'emms-last-played-update-current)
  ; NOTE: If this binding doesn't work, frob Gnome/Mutter with:
  ; gsettings set org.gnome.mutter.keybindings switch-monitor "[]"
  (global-set-key (kbd "s-p") 'emms-smart-browse)
  (setq emms-player-list '(emms-player-vlc)
        emms-info-functions '(emms-info-native)
        emms-mode-line-mode-line-function #'bsb/emms-mode-line-blurb
        emms-track-initialize-functions #'emms-info-initialize-track
        emms-browser-covers #'emms-browser-cache-thumbnail-async
        emms-source-file-default-directory "~/Music/"))

(defun bsb/truncate-string (string limit)
  (if (< (string-width string) limit)
      string
    (concat (seq-subseq string 0 (- limit 3)) "...")))

(defvar bsb/emms-mode-line-format "[ %s - %s ]")

(defun bsb/emms-mode-line-blurb ()
  (let* ((track (emms-playlist-current-selected-track))
         (desc-limit 30)
         (artist (bsb/truncate-string (emms-track-get track 'info-artist) desc-limit))
         (title (bsb/truncate-string (emms-track-get track 'info-title) desc-limit)))
    (format bsb/emms-mode-line-format artist title)))

(defun bsb/gimme-music ()
  (interactive)
  (emms-browse-by-album)
  (let ((count (count-lines (point-min) (point-max))))
    (goto-line (random count))
    (emms-browser-add-tracks-and-play)))

(global-set-key (kbd "s-m") 'bsb/gimme-music)
