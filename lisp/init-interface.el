;; Disable startup screen
(setq inhibit-startup-message t
      initial-scratch-message "")


;; Default Farme size
(setq default-frame-alist '((width  . 180)
                            (height . 52)
                            (top    . 32)
                            (left   . 130)))


;; Disable blink cursor
(setq blink-cursor-mode nil)


;; Hide interface elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; Fonts
(set-frame-font "Eco Coding 16" t t)
(set-fontset-font t 'han (font-spec :family "PingFang SC"))


;; Theme
(use-package birds-of-paradise-plus-theme
  :init
  (load-theme 'birds-of-paradise-plus t))


;; Relative line number
(use-package linum-relative
  :init
  (setq linum-relative-current-symbol "->"
        linum-relative-format "%2s")
  (global-linum-mode t)
  (linum-relative-global-mode))


;; Nyan cat
(use-package nyan-mode
  :init
  (setq nyan-bar-length 24)
  (nyan-mode))


(provide 'init-interface)
