lisp-mode

(pax "(mgl-pax:define-package :" (p "package-name? " package nil)
  n> "(:use :cl :mgl-pax)"
  n> "(:local-nicknames (:util :serapeum/bundle)))"
  n n "(in-package :" package ")"
  n n "(defsection @" p " (:title \"" p "\"))")

(tests "(defpackage :" (p "package-name? " package nil)
  n> "(:use :cl :try :" (p "source-name? " source nil) ")"
  n> "(:export #:" (p "test-name? " test nil) "))"
  n n "(in-package :" package ")"
  n n "(deftest " test " ())")
