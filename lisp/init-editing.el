;; -*- lexical-binding: t; -*-
(show-paren-mode t)
(column-number-mode t)
(electric-pair-mode t)
(global-subword-mode t)

(global-set-key (kbd "C-o") 'other-window)

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)

(global-set-key (kbd "C-;") 'comment-dwim)
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "M-w") 'kill-region)

(global-set-key (kbd "C-<wheel-up>") 'ignore)
(global-set-key (kbd "C-<wheel-down>") 'ignore)
(global-set-key (kbd "C-M-<wheel-up>") 'ignore)
(global-set-key (kbd "C-M-<wheel-down>") 'ignore)

(global-set-key (kbd "<f9>") 'delete-window)
(global-set-key (kbd "<f10>") 'delete-other-windows)


(use-package goto-line-preview
  :bind
  ("C-c C-l" . goto-line-preview))

(use-package goto-last-change
  :bind
  ("C--" . goto-last-change))

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package visual-regexp
  :bind
  ("C-r" . vr/replace))

(use-package expand-region
  :bind
  (("C-'" . er/expand-region)
   ("C-\"" . er/contract-region)))

(use-package aggressive-indent
  :config
  (add-to-list 'aggressive-indent-excluded-modes 'python-ts-mode)
  (global-aggressive-indent-mode t))

(use-package vundo
  :bind
  ("C-=" . vundo))

(use-package avy
  :custom
  (avy-keys '(?o ?e ?u ?h ?l ?r ?p ?a ?s ?d ?f ?g ?j ?k ?c ?v ?b ?w ?q))
  (avy-styles-alist '((avy-goto-char . de-bruijn)))
  :bind
  (("C-." . avy-goto-char)
   ("C-," . avy-goto-char-in-line)
   ("C-l" . avy-goto-line)))

(set-default 'cursor-type 'bar)
(use-package god-mode
  :custom
  (god-mode-enable-function-key-translation nil)
  :config
  (defun my/toggle-god-mode ()
    (interactive)
    (god-mode-all)
    (set-default 'cursor-type (if god-local-mode 'box 'bar)))
  (defun my/disable-god-mode ()
    (interactive)
    (when god-local-mode
      (god-mode-all)
      (set-default 'cursor-type 'bar)))
  (defun my/insert-and-disable-god-mode ()
    (interactive)
    (insert last-input-event)
    (my/disable-god-mode))
  :bind
  ("<f12>" . my/toggle-god-mode)
  (:map god-local-mode-map
        (";" . my/insert-and-disable-god-mode)
        (":" . my/insert-and-disable-god-mode)
        ("(" . my/insert-and-disable-god-mode)
        (")" . my/insert-and-disable-god-mode)
        ("[" . my/insert-and-disable-god-mode)
        ("]" . my/insert-and-disable-god-mode)
        ("{" . my/insert-and-disable-god-mode)
        ("}" . my/insert-and-disable-god-mode)))

(use-package open-newline
  :straight (:type git :host github :repo "manateelazycat/open-newline")
  :config
  (defun my/open-newline-below-and-disable-god-mode ()
    (interactive)
    (call-interactively 'open-newline-below)
    (my/disable-god-mode))
  (defun my/open-newline-above-and-disable-god-mode ()
    (interactive)
    (call-interactively 'open-newline-above)
    (my/disable-god-mode))
  :bind
  (("C-c C-n" . my/open-newline-below-and-disable-god-mode)
   ("C-c C-p" . my/open-newline-above-and-disable-god-mode)))

(use-package hydra
  :defer t)

(defhydra avy-hydra (:color blue :columns 3)
  "Avy Hydra"
  ("c" avy-copy-line "copy-line")
  ("k" avy-kill-whole-line "kill-line")
  ("m" avy-move-line "move-line")
  ("C" avy-copy-region "copy-region")
  ("K" avy-kill-region "kill-region")
  ("M" avy-move-region "move-region"))
(global-set-key (kbd "C-t") 'avy-hydra/body)

;; http://stackoverflow.com/questions/25188206/how-do-you-write-an-emacs-lisp-function-to-replace-a-word-at-point
(defun my/screaming-snake-case-word ()
  "Convert a camelCase word at point to SCREAMING_SNAKE_CASE."
  (interactive)
  (let* ((bounds
          (if (use-region-p)
              (cons (region-beginning) (region-end))
            (bounds-of-thing-at-point 'symbol)))
         (text (buffer-substring-no-properties (car bounds) (cdr bounds))))
    (when bounds
      (delete-region (car bounds) (cdr bounds))
      (insert (let ((case-fold-search nil))
                (upcase (replace-regexp-in-string "\\([A-Z]\\)" "_\\1" text t)))))))
(global-set-key (kbd "M-S") 'my/screaming-snake-case-word)

;; http://emacsredux.com/blog/2013/04/28/switch-to-previous-buffer/
(defun my/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (local-unset-key (kbd "C-c C-b"))))
(global-set-key (kbd "C-c C-b") 'my/switch-to-previous-buffer)


(provide 'init-editing)
