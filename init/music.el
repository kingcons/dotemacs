(use-package emms
  :pin gnu
  :bind
  (:map emms-playlist-mode-map
        ("o" . bsb/emms-load-playlist))
  (:map emms-browser-mode-map
        ("o" . bsb/emms-load-playlist))
  :config
  (emms-minimalistic)
  (require 'emms-cache)
  (require 'emms-browser)
  (require 'emms-mode-line)
  (require 'emms-tag-editor)
  (require 'emms-info-native)
  (require 'emms-last-played)
  (require 'emms-playlist-mode)
  ; To eval on first run only. Expect some lag.
  ; Takes about ~11m for 3600 flacs: 300 tracks/min.
  ; Worth running an explicit (emms-cache-save) after just to be sure.
  ; (emms-add-directory-tree "~/Music/")
  ; TODO: Boy would it be nice if EMMS synced when new dirs are added.
  (emms-cache 1)
  (emms-mode-line-enable)
  (advice-add 'emms-browser-display-playlist :before 'bsb/store-windows)
  (advice-add 'emms-browser-hide-linked-window :after 'bsb/restore-windows)
  ; NOTE: If this binding doesn't work, frob Gnome/Mutter with:
  ; gsettings set org.gnome.mutter.keybindings switch-monitor "[]"
  (setq emms-player-list '(emms-player-vlc)
        emms-info-functions '(emms-info-native)
        emms-mode-line-mode-line-function #'bsb/emms-mode-line-blurb
        emms-track-initialize-functions #'emms-info-initialize-track
        emms-track-description-function #'emms-info-track-description
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

(defun bsb/emms-load-playlist (file)
  (interactive
   (let ((playlist-dir (expand-file-name "playlists/" bsb/config-dir)))
     (list (read-file-name "Playlist file: " playlist-dir))))
  (emms-source-add 'emms-source-playlist file))

(defun bsb/random-album ()
  (interactive)
  (emms-browse-by-album)
  (let ((count (count-lines (point-min) (point-max))))
    (goto-line (random count))))

(global-set-key (kbd "s-r") 'bsb/random-album)
(global-set-key (kbd "s-p") 'emms-smart-browse)
