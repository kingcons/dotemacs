(use-package cc-mode
  :after eglot
  :hook (c-mode . eglot-ensure)
  :mode (("\\.c\\'" . c-mode)
         ("\\.h\\'" . c-mode)
         ("\\.cpp\\'" . c++-mode)
         ("\\.cc\\'" . c++-mode)
         ("\\.hpp\\'" . c++-mode))
  :init
  (add-to-list 'eglot-server-programs '(c-mode . ("ccls")))
  (add-to-list 'eglot-server-programs '(c++-mode . ("ccls")))
  :custom
  (c-basic-offset 4)
  (c-default-style "k&r"))
