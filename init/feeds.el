(defvar bsb/blogroll
  '("https://www.hillelwayne.com/index.xml"
    "https://danluu.com/atom.xml"
    "https://pvk.ca/atom.xml"
    "https://wingolog.org/feed/atom"
    "https://technomancy.us/atom.xml"
    "https://blog.fogus.me/feed/"
    "https://lispblog.xach.com/rss"
    "https://stevelosh.com/rss.xml"
    "https://raganwald.com/rss.xml"
    "https://borretti.me/feed.xml"
    "https://mr.gy/blog/index.xml"
    "https://jvns.ca/atom.xml"
    "https://aphyr.com/posts.atom"
    "http://journal.stuffwithstuff.com/rss.xml"
    "https://eli.thegreenplace.net/feeds/all.atom.xml"
    "http://feeds.akkartik.name/kartiks-scrapbook"
    "https://hyperthings.garden/rss/all-posts.xml"
    ;; Podcasts and other media
    "https://feeds.simplecast.com/L9810DOa"
    "https://link.chtbl.com/corecursive?platform=rss"))

;; add elfeed since rss and atom are still great

(use-package elfeed
  :bind (("s-r" . elfeed))
  :config
  (setq elfeed-feeds bsb/blogroll))
