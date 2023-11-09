;; -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(font . "PragmataPro Mono 18"))
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

(use-package minions
  :config
  (minions-mode t))

(use-package ace-window
  :custom
  (aw-keys '(?1 ?2 ?3 ?4 ?5 ?6 ?7))
  :custom-face
  (aw-leading-char-face ((t (:height 1.0))))
  :bind
  ("M-'" . ace-window))

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
