;; -*- lexical-binding: t; -*-
(column-number-mode)

;; (global-hl-line-mode)
;; (add-hook 'activate-mark-hook (lambda () (global-hl-line-mode 0)))
;; (add-hook 'deactivate-mark-hook (lambda () (global-hl-line-mode 1)))

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
  (minions-mode 1))

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
