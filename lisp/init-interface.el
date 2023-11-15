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

(use-package rainbow-mode
  :defer t)

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

(use-package neotree
  :custom
  (neo-theme 'arrow)
  (neo-smart-open t)
  (neo-autorefresh nil)
  (neo-mode-line-type 'none)
  (neo-window-position 'right)
  (neo-default-system-application "open")
  (neo-hidden-regexp-list '("^\\." "\\.pyc$" "~$" "^#.*#$" "\\.elc$" "node_modules"))
  :custom-face
  (neo-dir-link-face ((t (:inherit font-lock-builtin-face))))
  (neo-expand-btn-face ((t (:inherit font-lock-builtin-face))))
  :bind
  (("C-c e"   . neotree-show)
   ("C-c t"   . neotree-toggle)
   ("C-c C-o" . neotree-open-file-in-system-application)))

(use-package popper
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "\\*Backtrace\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode))
  (popper-mode)
  (popper-echo-mode)
  :bind
  (("C-c C-t" . popper-toggle)
   ("C-;"     . popper-cycle)
   ("C-:"     . popper-toggle-type)))


(provide 'init-interface)
