;; -*- lexical-binding: t; -*-
(show-paren-mode t)
(column-number-mode t)
(electric-pair-mode t)
(global-subword-mode t)

(global-set-key (kbd "<f12>") 'save-buffer)
(global-set-key (kbd "C-o") 'other-window)

(global-set-key (kbd "C-;") 'comment-dwim)
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "M-w") 'kill-region)

(global-set-key (kbd "C-<wheel-up>") 'ignore)
(global-set-key (kbd "C-<wheel-down>") 'ignore)
(global-set-key (kbd "C-M-<wheel-up>") 'ignore)
(global-set-key (kbd "C-M-<wheel-down>") 'ignore)

(global-set-key (kbd "<f9>") 'delete-window)
(global-set-key (kbd "<f10>") 'delete-other-windows)

(use-package rg
  :defer t)

(use-package wgrep
  :defer t)

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

(use-package expreg
  :bind
  ("C-'" . expreg-expand))

(use-package aggressive-indent
  :hook ((emacs-lisp-mode . (lambda ()
                              (aggressive-indent-mode 1)
                              (electric-indent-local-mode -1)))))

(use-package avy
  :custom
  (avy-keys '(?o ?e ?u ?h ?l ?r ?p ?a ?s ?d ?f ?g ?j ?k ?c ?v ?b ?w ?q))
  (avy-styles-alist '((avy-goto-char . de-bruijn)))
  :bind
  (("C-." . avy-goto-char)
   ("C-," . avy-goto-char-in-line)
   ("C-l" . avy-goto-line)))

(use-package open-newline
  :straight (:type git :host github :repo "manateelazycat/open-newline")
  :bind
  (("C-c C-n" . open-newline-below)
   ("C-c C-p" . open-newline-above)))


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
