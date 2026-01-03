;; -*- lexical-binding: t; -*-
(setq display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook (lambda () (display-line-numbers-mode t)))

(use-package evil
  :init
  (setq evil-want-keybinding      nil
        evil-undo-system         'undo-fu
        evil-emacs-state-cursor  'bar
        evil-visual-state-cursor 'hollow)
  :config
  (evil-mode)
  (evil-set-leader 'normal (kbd "SPC"))
  (defalias 'evil-insert-state 'evil-emacs-state)
  (defalias 'evil-motion-state 'evil-emacs-state)
  (with-eval-after-load 'git-commit
    (add-hook 'git-commit-mode-hook #'evil-emacs-state))
  (with-eval-after-load 'avy
    (let ((original-action (alist-get ?x avy-dispatch-alist)))
      (defun my/avy-action-kill-move-then-insert (pt)
        (prog1
            (funcall (or original-action #'avy-action-kill-move) pt)
          (when (featurep 'evil)
            (evil-insert-state))))
      (setf (alist-get ?x avy-dispatch-alist) #'my/avy-action-kill-move-then-insert))))

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
