;; -*- lexical-binding: t; -*-
(show-paren-mode t)
(column-number-mode t)
(electric-pair-mode t)
(global-subword-mode t)

(global-set-key (kbd "C-o") 'other-window)

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)

(global-set-key (kbd "C-;") 'comment-dwim)

(global-set-key (kbd "C-<wheel-up>") 'ignore)
(global-set-key (kbd "C-<wheel-down>") 'ignore)
(global-set-key (kbd "C-M-<wheel-up>") 'ignore)
(global-set-key (kbd "C-M-<wheel-down>") 'ignore)

(global-set-key (kbd "<f9>") 'delete-window)
(global-set-key (kbd "<f10>") 'delete-other-windows)


(use-package goto-line-preview
  :bind
  ("C-c C-l" . goto-line-preview))

(use-package open-newline
  :straight (:type git :host github :repo "manateelazycat/open-newline")
  :bind
  (("C-c C-n" . open-newline-below)
   ("C-c C-p" . open-newline-above)))

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
   ("C-<return>" . avy-goto-line)))

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
(global-set-key (kbd "C-c C-g") 'avy-hydra/body)


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


(provide 'init-editing)
