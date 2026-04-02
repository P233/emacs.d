;; -*- lexical-binding: t; -*-
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))

(use-package evil
  :init
  (setq evil-want-keybinding      nil
        evil-undo-system         'undo-redo
        evil-emacs-state-cursor  'bar
        evil-visual-state-cursor 'hollow
        evil-disable-insert-state-bindings t)
  :config
  (evil-mode)
  (evil-set-leader 'normal (kbd "SPC"))
  (defalias 'evil-motion-state 'evil-emacs-state)
  (with-eval-after-load 'git-commit
    (add-hook 'git-commit-mode-hook #'evil-emacs-state))
  (with-eval-after-load 'avy
    (defun my/avy-action-kill-move-then-insert (pt)
      "Kill the Avy target at PT, move there, and enter insert state."
      (prog1 (avy-action-kill-move pt)
        (evil-insert-state)))
    (setf (alist-get ?x avy-dispatch-alist) #'my/avy-action-kill-move-then-insert)))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-goggles
  :after evil
  :custom
  (evil-goggles-enable-change nil)
  (evil-goggles-enable-delete nil)
  :config
  (evil-goggles-mode))

(use-package evil-matchit
  :after evil
  :config
  (global-evil-matchit-mode))

(use-package evil-escape
  :after evil
  :custom
  (evil-escape-delay 0.15)
  (evil-escape-key-sequence "uh")
  :config
  (evil-escape-mode))

(use-package evil-nerd-commenter
  :after evil
  :config
  (evilnc-default-hotkeys))

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode))


(provide 'init-evil)
