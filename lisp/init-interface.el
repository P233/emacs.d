;; -*- lexical-binding: t; -*-
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(column-number-mode)
(global-prettify-symbols-mode)

(global-hl-line-mode)
(add-hook 'activate-mark-hook (lambda () (global-hl-line-mode 0)))
(add-hook 'deactivate-mark-hook (lambda () (global-hl-line-mode 1)))

(add-to-list 'default-frame-alist '(font . "PragmataPro Mono Liga 18"))
(set-fontset-font "fontset-default" 'han "FZFW ZhuZi MinchoS")

(use-package ef-themes
  :config
  (defun my/apply-theme (appearance)
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('dark (load-theme 'ef-winter :no-confirm))
      ('light (load-theme 'ef-summer :no-confirm)))
    (set-face-bold-p 'bold nil))
  (add-hook 'ns-system-appearance-change-functions #'my/apply-theme))

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
