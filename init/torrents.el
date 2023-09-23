;; The following helpers try not to assume much but:
;; 1. You should have both [[rtorrent]] and [[https://flood.js.org/][flood]] installed on $PATH
;; 2. You should be comfortable running both as your logged in user on the local network
;; Afterwards, a flood server will be available on localhost:3000

(defvar bsb/rtorrent-dir
  (if (eq system-type 'gnu/linux)
      "/media/cons/Backup"
    (expand-file-name "Downloads" "~")))

(defvar bsb/rtorrent-command
  (let* ((socket (expand-file-name "rtorrent.socket" "~"))
         (option-daemon "system.daemon.set=true")
         (option-network (concat "network.scgi.open_local=" socket))
         (option-directory (concat "directory.default.set=" bsb/rtorrent-dir)))
    (format "rtorrent -o %s,%s,%s" option-daemon option-network option-directory)))

(defun bsb/start-rtorrent ()
  (bsb/run-in-shell "*rtorrent*" bsb/rtorrent-command))

(defun bsb/start-flood ()
  (bsb/run-in-shell "*flood*" "flood"))

(defun bsb/start-torrents ()
  (interactive)
  (bsb/start-rtorrent)
  (bsb/start-flood))

(global-set-key (kbd "s-t") 'bsb/start-torrents)
