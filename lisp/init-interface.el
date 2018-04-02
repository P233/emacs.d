;; Disable startup screen
(setq inhibit-startup-message t
      initial-scratch-message "")


;; Display buffer name on titlebar
(setq frame-title-format "%b")


;; Hide scroll bar
(scroll-bar-mode -1)


;; Hide tool bar
(tool-bar-mode -1)


;; Show column number
(column-number-mode)


;; Disable blinking cursor
(blink-cursor-mode -1)


;; Enable show-paren-mode
(setq show-paren-delay 0)
(show-paren-mode t)


;; Set fonts
(set-frame-font "PragmataPro Mono 16" t t)
(set-fontset-font t 'han (font-spec :family "PingFang SC"))
(mac-auto-operator-composition-mode t) ; Enable ligatures


;; Nyan cat mode
(use-package nyan-mode
  :init
  (setq nyan-bar-length 24))


;; Relative line number mode
(use-package nlinum-relative
  :config
  (setq nlinum-relative-current-symbol "->"))


;; Rainbow delimiters mode
(use-package rainbow-delimiters
  :config
  (set-face-background 'rainbow-delimiters-unmatched-face "#cc241d")
  (set-face-background 'rainbow-delimiters-mismatched-face "#cc241d"))


;; Enable minor modes for programming languages only
(add-hook 'prog-mode-hook
          (lambda ()
            (nyan-mode)
            (hs-minor-mode)
            (nlinum-relative-mode)
            (rainbow-delimiters-mode)))


;; Default color theme
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox t)
  (set-face-foreground 'linum "#a89984"))



(provide 'init-interface)
