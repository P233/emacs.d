;; -*- lexical-binding: t; -*-
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode)
(global-prettify-symbols-mode)

(add-to-list 'default-frame-alist '(font . "PragmataPro Mono Liga 18"))
(set-fontset-font "fontset-default" 'han "FZFW ZhuZi MinchoS")
(set-face-foreground 'vertical-border "gray")

(use-package doom-modeline
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-minor-modes t)
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
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
