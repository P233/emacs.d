;; Disable startup screen
(setq inhibit-startup-message t
      initial-scratch-message "")


;; Hide interface elements
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; Set fonts
(set-frame-font "PragmataPro 16" t t)
(set-fontset-font t 'han (font-spec :family "PingFang SC"))


;; Set default farme size
(setq default-frame-alist '((width  . 180)
                            (height . 52)
                            (top    . 32)
                            (left   . 130)))


;; Set theme
(use-package gruvbox-theme
  :config
  (set-face-foreground 'fringe "#665c54")
  (set-face-foreground 'default "#ebdbb2"))


;; Enable relative line number
(use-package linum-relative
  :init
  (setq linum-relative-current-symbol "->"
        linum-relative-format "%2s")
  (global-linum-mode t)
  (linum-relative-toggle)
  :config
  (set-face-attribute 'linum-relative-current-face nil :foreground "#fabd2f" :weight 'normal))


;; Enable column number
(column-number-mode)


;; Disable blinking cursor
(blink-cursor-mode -1)


;; Enable nyan-cat mode
(use-package nyan-mode
  :init
  (setq nyan-bar-length 24)
  (nyan-mode))



(provide 'init-interface)
