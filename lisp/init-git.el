(use-package magit
  :bind
  ("C-c m" . magit-status))


(use-package git-gutter-fringe
  :config
  (global-git-gutter-mode t))


(use-package git-timemachine)

(use-package vc-msg
  :bind
  ("C-c C-'" . vc-msg-show))



(provide 'init-git)
