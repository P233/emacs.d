;; -*- lexical-binding: t; -*-
(use-package hydra)

(defhydra hydra-avy (:color blue :columns 3)
  "Avy Hydra"
  ("c" avy-copy-line "copy-line")
  ("k" avy-kill-whole-line "kill-line")
  ("m" avy-move-line "move-line")
  ("C" avy-copy-region "copy-region")
  ("K" avy-kill-region "kill-region")
  ("M" avy-move-region "move-region"))
(global-set-key (kbd "C-c C-g") 'hydra-avy/body)



(provide 'init-hydra)
