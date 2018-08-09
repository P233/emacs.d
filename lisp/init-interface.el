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
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family "Kai")))
(mac-auto-operator-composition-mode t) ; Enable ligatures


;; Nyan cat mode
(use-package nyan-mode
  :init
  (setq nyan-bar-length 24))


;; Relative line number mode
(setq display-line-numbers-type 'relative
      display-line-numbers-current-absolute nil)


;; Rainbow delimiters mode
(use-package rainbow-delimiters)


;; Enable minor modes for programming languages only
(add-hook 'prog-mode-hook
          (lambda ()
            (nyan-mode)
            (hs-minor-mode)
            (display-line-numbers-mode)
            (rainbow-delimiters-mode)))


;; Default color theme
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))



(provide 'init-interface)
