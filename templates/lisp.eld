lisp-mode

(pax "(mgl-pax:define-package :" (p "package-name? " package nil)
  n> "(:use :cl :mgl-pax)"
  n> "(:local-nicknames (:util :serapeum/bundle)))"
  n n "(in-package :" package ")"
  n n "(defsection @" p " (:title \"" p "\"))")
