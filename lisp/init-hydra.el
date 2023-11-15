;; -*- lexical-binding: t; -*-
(use-package hydra)

(use-package avy
  :custom
  (avy-keys '(?o ?e ?u ?h ?l ?r ?p ?a ?s ?d ?f ?g ?j ?k ?c ?v ?b ?w ?q))
  (avy-styles-alist '((avy-goto-char . de-bruijn)))
  :bind
  (("C-." . avy-goto-char)
   ("C-," . avy-goto-char-in-line)))

(use-package evil
  :custom
  (evil-default-state 'emacs)
  :config
  (evil-mode 1)
  (defalias 'evil-insert-state 'evil-emacs-state)
  (defalias 'evil-motion-state 'evil-emacs-state)
  (setq evil-undo-system 'undo-redo
        evil-normal-state-cursor '(hbar . 4)
        evil-operator-state-cursor '(hbar . 9)
        evil-visual-state-cursor 'hollow))

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
  ("rd" (progn (call-interactively 'evil-delete) (avy-pop-mark)))
  ("ry" (progn (call-interactively 'evil-yank) (avy-pop-mark)))
  ("gd" (progn (call-interactively 'evil-delete) (avy-goto-word-0 "")))
  ("gy" (progn (call-interactively 'evil-yank) (avy-goto-word-0 ""))))

(global-set-key (kbd "C-M-'") 'evil-execute-in-normal-state)

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


(provide 'init-hydra)
