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
  (load-theme 'gruvbox t)
  (set-face-foreground 'default "#ebdbb2")
  (set-face-foreground 'fringe "#665c54"))


;; Switch theme
(defvar current-theme-name "gruvbox")
(defun switch-theme ()
  (interactive)
  (if (string-equal current-theme-name "gruvbox")
      (progn
        (disable-theme 'gruvbox)
        (set-face-foreground 'default "#000")
        (set-face-foreground 'fringe "#7f7f7f")
        (setq current-theme-name "default"))
    (progn
      (load-theme 'gruvbox t)
      (set-face-foreground 'default "#ebdbb2")
      (set-face-foreground 'fringe "#665c54")
      (setq current-theme-name "gruvbox"))))



(provide 'init-interface)
