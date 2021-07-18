:;; -*- lexical-binding: t; -*-
(setq show-paren-delay 0)
(show-paren-mode t)
(global-subword-mode t)

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)

(global-set-key (kbd "C-,") 'kill-ring-save)
(global-set-key (kbd "C-.") 'kill-region)

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package expand-region
  :bind
  (("C-'" . er/expand-region)
   ("C-=" . er/contract-region)))

(use-package visual-regexp
  :bind
  (("C-c r" . vr/replace)
   ("C-c q" . vr/query-replace)))

(use-package popup-kill-ring
  :bind
  ("C-c p" . popup-kill-ring))

(use-package avy
  :config
  (setq avy-keys '(?u ?h ?e ?t ?o ?n ?a ?s ?i ?d))
  :bind
  (("C-c '" . avy-goto-char)
   ("C-c l" . avy-goto-line)))

(use-package goto-last-change
  :bind
  ("C-`" . goto-last-change))

(use-package dumb-jump
  :config
  (set dumb-jump-selector 'ivy)
  :bind
  (("M-g g" . dumb-jump-go)
   ("M-g o" . dumb-jump-go-other-window)
   ("M-g b" . dumb-jump-back)))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(load (concat user-emacs-directory "custom-packages/emmet-mode/emmet-mode"))
(setq emmet-move-cursor-between-quotes t
      emmet-insert-flash-time 0.1)
(define-key emmet-mode-keymap (kbd "<C-return>") nil)

(use-package prettier-js)


(provide 'init-editing-tools)
