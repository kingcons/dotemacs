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

(defun bsb/album-header-for-track ()
  "Generates propertized cover image for the EMMS track at point."
  (let* ((track (emms-playlist-track-at (point)))
         (path (emms-track-get track 'name))
         (year (emms-track-get-year track))
         (album (emms-track-get track 'info-album))
         (cover (emms-browser-get-cover-from-path path))
         (cover-str (emms-browser-make-cover cover))
         (substring (format "(%s) %s" year album)))
    (add-text-properties 0 (length substring)
                         '(face emms-browser-album-face) substring)
    (format "%s %s\n" cover-str substring)))

(defun bsb/emms-load-playlist (file)
  (interactive
   (let ((playlist-dir (expand-file-name "playlists/" bsb/config-dir)))
     (list (read-file-name "Playlist file: " playlist-dir))))
  (emms-source-add 'emms-source-playlist file)
  (with-current-emms-playlist
    (save-excursion
      (goto-char (point-min))
      (let* ((initial-track (emms-playlist-track-at (point)))
             (current-album (emms-track-get initial-track 'info-album)))
        (insert (bsb/album-header-for-track))
        (while (zerop (forward-line))
          (let ((track (emms-playlist-track-at (point))))
            (unless (string= current-album (emms-track-get track 'info-album))
              (setq current-album (emms-track-get track 'info-album))
              (insert (bsb/album-header-for-track)))))))))

(defun bsb/random-album ()
  (interactive)
  (emms-browse-by-album)
  (let ((count (count-lines (point-min) (point-max))))
    (goto-line (random count))))

(global-set-key (kbd "s-r") 'bsb/random-album)
(global-set-key (kbd "s-p") 'emms-smart-browse)
