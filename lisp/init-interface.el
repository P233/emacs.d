;; Disable startup screen
(setq inhibit-startup-message t
      initial-scratch-message "")


;; Hide interface elements
(tool-bar-mode -1)
(toggle-scroll-bar -1)
(add-hook 'after-make-frame-functions
          (lambda (frame)
            (modify-frame-parameters frame
                                     '((vertical-scroll-bars . nil)))))


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


;; Enable relative line number
(use-package linum-relative
  :init
  (setq linum-relative-current-symbol "->"
        linum-relative-format "%2s")
  (global-linum-mode t)
  (linum-relative-toggle))


;; Set default theme
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox t)
  (set-face-foreground 'default "#ebdbb2")
  (set-face-foreground 'fringe "#665c54")
  (set-face-attribute 'linum-relative-current-face nil :foreground "#fabd2f" :background "#282828" :weight 'normal))


;; Switch theme
(defvar current-theme-name "gruvbox")
(defun switch-theme ()
  (interactive)
  (if (string-equal current-theme-name "gruvbox")
      (progn
        (disable-theme 'gruvbox)
        (set-face-foreground 'default "#000")
        (set-face-foreground 'fringe "#7f7f7f")
        (set-face-attribute 'linum-relative-current-face nil :foreground "#b92028" :background "#f0f0f0" :weight 'normal)
        (setq current-theme-name "default"))
    (progn
      (load-theme 'gruvbox t)
      (set-face-foreground 'default "#ebdbb2")
      (set-face-foreground 'fringe "#665c54")
      (set-face-attribute 'linum-relative-current-face nil :foreground "#fabd2f" :background "#282828" :weight 'normal)
      (setq current-theme-name "gruvbox"))))


;; Set default farme size
(setq default-frame-alist '((width  . 200)
                            (height . 56)
                            (top    . 0)
                            (left   . 150)))



(provide 'init-interface)
