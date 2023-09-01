;; -*- lexical-binding: t; -*-
(use-package ef-themes
  :config
  (defun my/apply-theme (appearance)
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('dark (load-theme 'ef-winter :no-confirm))
      ('light (load-theme 'ef-summer :no-confirm))))
  (add-hook 'ns-system-appearance-change-functions #'my/apply-theme))

(use-package minions
  :config
  (minions-mode t))

(use-package window-numbering
  :config
  (window-numbering-mode))

(use-package rainbow-delimiters
  :defer t
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package doom-modeline
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-minor-modes t)
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  :hook
  (after-init . doom-modeline-mode))


(provide 'init-interface)
