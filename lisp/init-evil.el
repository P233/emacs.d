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
  (evil-define-key 'normal 'global  (kbd "<leader>/")   'my/swiper-thing-at-point)
  (evil-define-key 'normal 'global  (kbd "<leader>2")   'my/split-window-below)
  (evil-define-key 'normal 'global  (kbd "<leader>3")   'my/split-window-right)
  (evil-define-key 'normal 'global  (kbd "<leader>L")   'avy-goto-end-of-line)
  (evil-define-key 'normal 'global  (kbd "<leader>O")   'open-newline-above)
  (evil-define-key 'normal 'global  (kbd "<leader>b")   'persp-ivy-switch-buffer)
  (evil-define-key 'normal 'global  (kbd "<leader>f")   'counsel-find-file)
  (evil-define-key 'normal 'global  (kbd "<leader>h f") 'counsel-describe-function)
  (evil-define-key 'normal 'global  (kbd "<leader>h k") 'describe-key)
  (evil-define-key 'normal 'global  (kbd "<leader>h v") 'counsel-describe-variable)
  (evil-define-key 'normal 'global  (kbd "<leader>k")   'kill-buffer)
  (evil-define-key 'normal 'global  (kbd "<leader>v")   'magit-status)
  (evil-define-key 'normal 'global  (kbd "<leader>l")   'avy-goto-char-in-line)
  (evil-define-key 'normal 'global  (kbd "<leader>o")   'open-newline-below)
  (evil-define-key 'normal 'global  (kbd "<leader>r")   'vr/replace)
  (evil-define-key 'normal 'global  (kbd "<leader>s")   'my/switch-to-previous-buffer)
  (evil-define-key 'normal 'global  (kbd "<leader>w")   'save-buffer)
  (evil-define-key 'normal 'global  (kbd "<leader>x")   'counsel-M-x)
  (evil-define-key 'normal 'global  (kbd "<leader>Z")   'save-buffers-kill-terminal)
  (define-key evil-emacs-state-map  (kbd "ESC")        #'evil-normal-state)
  (define-key evil-normal-state-map (kbd "s")          #'avy-goto-char-2)
  (define-key evil-normal-state-map (kbd "u")          #'undo-fu-only-undo)
  (define-key evil-normal-state-map (kbd "U")          #'undo-fu-only-redo)
  (define-key evil-normal-state-map (kbd "/")          #'swiper)
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

(with-eval-after-load 'jsx-jedi
  ;; Use "," as a second leader key specifically for jsx-jedi
  (evil-define-key 'normal jsx-jedi-mode-map (kbd ",") (make-sparse-keymap))
  (evil-define-key 'normal jsx-jedi-mode-map
    (kbd ", k") 'jsx-jedi-kill
    (kbd ", e") (lambda () (interactive) (when (jsx-jedi-empty) (evil-insert-state)))
    (kbd ", s") 'jsx-jedi-substitute
    (kbd ", z") (lambda () (interactive) (when (jsx-jedi-zap) (evil-insert-state)))
    (kbd ", y") 'jsx-jedi-copy
    (kbd ", d") 'jsx-jedi-duplicate
    (kbd ", m") 'jsx-jedi-mark
    (kbd ", ;") 'jsx-jedi-comment-uncomment
    (kbd ", j") 'jsx-jedi-avy-word
    (kbd ", h") 'jsx-jedi-hoist-tag
    (kbd ", u") 'jsx-jedi-unwrap-tag
    (kbd ", w") 'jsx-jedi-wrap-tag
    (kbd ", [") 'jsx-jedi-move-to-opening-tag
    (kbd ", ]") 'jsx-jedi-move-to-closing-tag
    (kbd ", r") 'jsx-jedi-rename-tag
    (kbd ", t") 'jsx-jedi-toggle-self-closing-tag
    (kbd ", a") (lambda () (interactive) (when (jsx-jedi-add-attribute) (evil-insert-state))))
  ;; Map "\" to the original "," functionality (reverse character search)
  (evil-define-key 'normal jsx-jedi-mode-map (kbd "\\") #'evil-repeat-find-char-reverse))

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
  (evil-escape-key-sequence "jk")
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
