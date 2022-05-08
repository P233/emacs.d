;; -*- lexical-binding: t; -*-
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode)
(global-prettify-symbols-mode)

(add-to-list 'default-frame-alist '(font . "PragmataPro Mono Liga 18"))
(set-fontset-font "fontset-default" 'han "FZFW ZhuZi MinchoS")

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

(use-package rainbow-delimiters
  :defer t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package pragmatapro-lig
  :load-path "custom-packages/emacs-pragmatapro-ligatures"
  :hook
  (prog-mode . pragmatapro-lig-mode))


(provide 'init-interface)
