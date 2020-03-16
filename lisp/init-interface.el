(setq frame-title-format nil
      inhibit-startup-message t
      initial-scratch-message "")

(scroll-bar-mode -1)
(tool-bar-mode -1)
(line-number-mode -1)
(blink-cursor-mode -1)

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
  :config
  (my/load-daytime-theme))

(use-package doom-modeline
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-minor-modes t)
  :hook
  (after-init . doom-modeline-mode))

(use-package minions
  :after doom-modeline
  :config
  (minions-mode 1))

(use-package window-numbering
  :after doom-modeline
  :config
  (window-numbering-mode))

(set-frame-font "PragmataPro Mono Liga 18" t t)
(dolist (charset '(kana han cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font) charset
                    (font-spec :family "Kai")))

(load (expand-file-name "custom-packages/emacs-pragmatapro-ligatures/pragmatapro-lig" user-emacs-directory))
(add-hook 'prog-mode-hook #'pragmatapro-lig-mode)
(global-prettify-symbols-mode)


(provide 'init-interface)
