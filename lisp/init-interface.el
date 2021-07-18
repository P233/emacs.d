;; -*- lexical-binding: t; -*-
(scroll-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode)

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
  :config
  (setq doom-modeline-icon nil
        doom-modeline-minor-modes t
        doom-modeline-buffer-file-name-style 'truncate-with-project)
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

(load (concat user-emacs-directory "custom-packages/emacs-pragmatapro-ligatures/pragmatapro-lig"))
(add-hook 'prog-mode-hook #'pragmatapro-lig-mode)
(global-prettify-symbols-mode)


(provide 'init-interface)
