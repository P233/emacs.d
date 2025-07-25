;; -*- lexical-binding: t; -*-
(add-to-list 'default-frame-alist '(font . "PragmataPro Mono 18"))
(set-fontset-font "fontset-default" 'han "Noto Serif SC Medium")

(pixel-scroll-precision-mode t)

(use-package ef-themes
  :config
  (defun my/apply-theme (appearance)
    (mapc #'disable-theme custom-enabled-themes)
    (pcase appearance
      ('dark (load-theme 'ef-winter :no-confirm))
      ('light (load-theme 'ef-summer :no-confirm))))
  (add-hook 'ns-system-appearance-change-functions #'my/apply-theme))

(use-package doom-modeline
  :custom
  (doom-modeline-icon nil)
  (doom-modeline-height 24)
  (doom-modeline-minor-modes t)
  (doom-modeline-buffer-file-name-style 'truncate-with-project)
  :hook
  (after-init . doom-modeline-mode))

(use-package minions
  :after doom-modeline
  :config
  (minions-mode t))

(use-package rainbow-mode
  :defer t)

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package popper
  :init
  (setq popper-reference-buffers
        '("\\*Async Shell Command\\*"
          "\\*Backtrace\\*"
          "\\*Messages\\*"
          "Output\\*$"
          help-mode
          compilation-mode))
  (popper-mode)
  (popper-echo-mode))

(use-package treemacs
  :custom
  (treemacs-width 28)
  (treemacs-text-scale nil)
  (treemacs-no-png-images t)
  (treemacs-show-hidden-files nil)
  :init
  (defun my/treemacs-ignore-files (_ absolute-path)
    (or (string-suffix-p "dist" absolute-path)
        (string-suffix-p "node_modules" absolute-path)))
  :config
  (treemacs-project-follow-mode t)
  (add-to-list 'treemacs-ignored-file-predicates #'my/treemacs-ignore-files)
  :custom-face
  (treemacs-root-face ((t (:height 1.1))))
  :bind
  ("<f3>" . treemacs)
  ("M-<f3>" . treemacs-select-window))


;; https://emacs-china.org/t/topic/945/2
(defun my/split-window-below ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-below))
  (switch-to-buffer (other-buffer)))
(global-set-key (kbd "C-x 2") 'my/split-window-below)

(defun my/split-window-right ()
  "Split window with another buffer."
  (interactive)
  (select-window (split-window-right))
  (switch-to-buffer (other-buffer)))
(global-set-key (kbd "C-x 3") 'my/split-window-right)


(provide 'init-interface)
