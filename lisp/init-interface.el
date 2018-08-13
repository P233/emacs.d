;; Disable startup screen
(setq inhibit-startup-message t
      initial-scratch-message "")


;; Titlebar Settings
;; defaults write org.gnu.Emacs TransparentTitleBar LIGHT
;; defaults write org.gnu.Emacs HideDocumentIcon YES
(setq frame-title-format nil)


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
(use-package gruvbox-theme
  :init
  (load-theme 'gruvbox-dark-hard t)
  :config
  (set-face-background 'mode-line-inactive "#282828")
  (set-face-background 'mode-line "#3C3836"))


;; Enable minor modes for programming languages only
(add-hook 'prog-mode-hook
          (lambda ()
            (hs-minor-mode)
            (rainbow-delimiters-mode)))



(provide 'init-interface)
