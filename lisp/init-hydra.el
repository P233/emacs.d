;; -*- lexical-binding: t; -*-
(use-package hydra)

(defhydra hydra-avy (:columns 3)
  "Avy Editing"
  ("cl" avy-copy-line "copy-line")
  ("kl" avy-kill-whole-line "kill-line")
  ("ml" avy-move-line "move-line")
  ("cr" avy-copy-region "copy-region")
  ("kr" avy-kill-region "kill-region")
  ("mr" avy-move-region "move-region"))
(global-set-key (kbd "C-.") 'hydra-avy/body)



(provide 'init-hydra)
