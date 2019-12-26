;; Disable startup screen
(setq inhibit-startup-message t
      initial-scratch-message "")


;; Titlebar Settings
(setq frame-title-format nil)


;; Hide scroll bar
(scroll-bar-mode -1)


;; Hide tool bar
(tool-bar-mode -1)


;; Disable line-number-mode
(line-number-mode -1)


;; Disable blinking cursor
(blink-cursor-mode -1)


;; Enable show-paren-mode
(setq show-paren-delay 0)
(show-paren-mode t)


;; Set fonts
(set-frame-font "PragmataPro Mono Liga 18" t t)
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family "Kai")))


;; Enable ligatures
(load (expand-file-name "custom-packages/emacs-pragmatapro-ligatures/pragmatapro-lig" user-emacs-directory))
(add-hook 'prog-mode-hook #'pragmatapro-lig-mode)


;; Window numbering mode
(use-package window-numbering
  :config
  (window-numbering-mode))


(use-package doom-modeline
  :custom
  (doom-modeline-icon nil)
  :hook
  (after-init . doom-modeline-mode))


;; Gruvbox Theme
(defun my/load-daytime-theme ()
  "Load gruvbox-light-soft theme."
  (interactive)
  (load-theme 'gruvbox-light-soft t)
  (set-face-attribute 'mode-line nil :foreground "#427B58" :background "#FAF0C9"))

(defun my/load-nighttime-theme ()
  "Load gruvbox-dark-hard theme."
  (interactive)
  (load-theme 'gruvbox-dark-hard t)
  (set-face-attribute 'mode-line nil :background "#282828"))

(use-package gruvbox-theme
  :after window-numbering
  :config
  (my/load-daytime-theme))


;; Minor mode menu
(use-package minions
  :config
  (minions-mode 1))


;; Hide mode-line-percent-position
(setq mode-line-percent-position nil)



(provide 'init-interface)
