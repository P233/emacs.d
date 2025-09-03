;; -*- lexical-binding: t; -*-
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))

(use-package evil
  :init
  (setq evil-want-keybinding nil
        evil-undo-system 'undo-fu
        evil-visual-state-cursor 'hollow
        evil-emacs-state-cursor 'bar)
  :config
  (evil-mode)
  (evil-set-leader 'normal (kbd "SPC"))
  (defalias 'evil-insert-state 'evil-emacs-state)
  (defalias 'evil-motion-state 'evil-emacs-state)
  (evil-define-key 'normal 'global  (kbd "<leader>b") 'persp-ivy-switch-buffer)
  (evil-define-key 'normal 'global  (kbd "<leader>w") 'save-buffer)
  (evil-define-key 'normal 'global  (kbd "<leader>x") 'counsel-M-x)
  (evil-define-key 'normal 'global  (kbd "<leader>f") 'counsel-find-file)
  (evil-define-key 'normal 'global  (kbd "<leader>k") 'kill-buffer)
  (evil-define-key 'normal 'global  (kbd "<leader>v") 'magit)
  (define-key evil-emacs-state-map  (kbd "<escape>") #'evil-normal-state)
  (define-key evil-normal-state-map (kbd "s") 'avy-goto-char-2)
  (define-key evil-normal-state-map (kbd "/") #'swiper))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))


(provide 'init-evil)
