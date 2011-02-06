;; After we add a word to Ispell or correct something, flyspell's highlighting may become
;; outdated. Let's re-run highlighting after a correction.
; (defadvice ispell (after advice)
;   (flyspell-buffer))
; (ad-activate 'ispell t)
; (defadvice ispell-word (after advice)
;   (flyspell-buffer))
; (ad-activate 'ispell-word t)
