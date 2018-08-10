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


;; Rainbow delimiters mode
(use-package rainbow-delimiters)


;; Doom Modeline
(use-package doom-modeline
  :config
  (setq doom-modeline-height 30))


;; Gruvbox Theme
;; (use-package gruvbox-theme)


;; Doom Theme
(use-package doom-themes
  :config
  (load-theme 'doom-nord-light t))


;; Enable minor modes for programming languages only
(add-hook 'prog-mode-hook
          (lambda ()
            (hs-minor-mode)
            (rainbow-delimiters-mode)))



(provide 'init-interface)
