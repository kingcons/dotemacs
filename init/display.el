(menu-bar-mode 0)
(scroll-bar-mode 0)
(tool-bar-mode 0)

(setq inhibit-splash-screen t)

;;Push the mouse out of the way when the cursor approaches.
(when window-system
  (autoload 'avoid "avoid" "Avoid mouse and cursor being near each other")
  (eval-after-load 'avoid (mouse-avoidance-mode 'jump)))
