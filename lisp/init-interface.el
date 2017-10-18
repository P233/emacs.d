;; Set default farme parameters
(setq default-frame-alist '((width  . 200)
                            (height . 56)
                            (top    . 0)
                            (left   . 150)
                            (vertical-scroll-bars . nil)))


;; Disable startup screen
(setq inhibit-startup-message t
      initial-scratch-message "")


;; Display buffer name on titlebar
(setq frame-title-format "%b")


;; Hide tool bar
(tool-bar-mode -1)


;; Show column number
(column-number-mode)


;; Disable blinking cursor
(blink-cursor-mode -1)


;; Set fonts
(set-frame-font "PragmataPro 16" t t)
(set-fontset-font t 'han (font-spec :family "PingFang SC"))
(mac-auto-operator-composition-mode t) ; Enable ligatures


;; Enable nyan-cat mode
(use-package nyan-mode
  :init
  (setq nyan-bar-length 24)
  (nyan-mode))


;; Set default theme
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox t))



(provide 'init-interface)
