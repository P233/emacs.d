;; -*- lexical-binding: t; -*-
(show-paren-mode t)
(column-number-mode t)
(electric-pair-mode t)
(global-subword-mode t)

(global-set-key (kbd "C-`") 'goto-last-change)

(add-hook 'prog-mode-hook #'hs-minor-mode)
(global-set-key (kbd "C-c h") 'hs-toggle-hiding)


(use-package goto-line-preview
  :bind
  ("M-g M-g" . goto-line-preview))

(use-package open-newline
  :straight (:type git :host github :repo "manateelazycat/open-newline")
  :bind
  (("M-RET" . open-newline-below)
   ("<C-return>" . open-newline-above)))

(use-package move-text
  :config
  (move-text-default-bindings))

(use-package visual-regexp
  :bind
  (("C-c r" . vr/replace)
   ("C-c q" . vr/query-replace)))

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
   ("C-c C-l" . avy-goto-line)))

(use-package evil
  :custom
  (evil-default-state 'emacs)
  :config
  (evil-mode)
  (defalias 'evil-insert-state 'evil-emacs-state)
  (defalias 'evil-motion-state 'evil-emacs-state)
  (setq evil-undo-system 'undo-redo
        evil-normal-state-cursor '(hbar . 4)
        evil-operator-state-cursor '(hbar . 9)
        evil-visual-state-cursor 'hollow))

(use-package hydra
  :defer t)


(defhydra evil-hydra (:color blue :hint nil)
  "
^Anchor^               ^Edit and Return^       ^Edit and Goto^
^^^^^^^^-------------------------------------------------------------
_c_: change
_d_: delete            _rd_: delete            _gd_: delete
_y_: yank              _ry_: yank              _gy_: yank
_p_: paste pop
"
  ("c" evil-change)
  ("d" evil-delete)
  ("y" evil-yank)
  ("p" counsel-yank-pop)
  ("rd" (progn (call-interactively 'evil-delete) (avy-pop-mark) (yank)))
  ("ry" (progn (call-interactively 'evil-yank) (avy-pop-mark) (yank)))
  ("gd" (progn (call-interactively 'evil-delete) (avy-goto-word-0 "")))
  ("gy" (progn (call-interactively 'evil-yank) (avy-goto-word-0 ""))))

(global-set-key (kbd "C-;") 'evil-execute-in-normal-state)

(global-set-key (kbd "C-M-.") (lambda ()
                                (interactive)
                                (call-interactively 'avy-goto-char)
                                (evil-hydra/body)))

(global-set-key (kbd "C-M-,") (lambda ()
                                (interactive)
                                (call-interactively 'avy-goto-char-in-line)
                                (evil-hydra/body)))


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
