;; -*- lexical-binding: t; -*-
(use-package magit
  :custom
  (magit-diff-highlight-hunk-region-functions '(magit-diff-highlight-hunk-region-dim-outside magit-diff-highlight-hunk-region-using-face))
  :custom-face
  (magit-diff-hunk-region ((t (:slant italic)))))

(use-package magit-prime
  :straight (:type git :host github :repo "Azkae/magit-prime")
  :config
  (add-hook 'magit-pre-refresh-hook 'magit-prime-refresh-cache))

(use-package diff-hl
  :custom
  (diff-hl-margin-symbols-alist '((insert  . " ")
                                  (delete  . " ")
                                  (change  . " ")
                                  (unknown . " ")
                                  (ignored . " ")))
  :config
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (global-diff-hl-mode))

(use-package vc-msg)

(use-package git-timemachine
  :defer t
  :config
  (with-eval-after-load 'evil
    (evil-make-overriding-map git-timemachine-mode-map 'normal)
    (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))


(provide 'init-git)
