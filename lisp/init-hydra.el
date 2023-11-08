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

;; https://ericjmritz.wordpress.com/2015/10/14/some-personal-hydras-for-gnu-emacs/
(defhydra hydra-corral (:columns 2)
  "Corral Editing"
  ("(" corral-parentheses-backward "Back")
  (")" corral-parentheses-forward "Forward")
  ("[" corral-brackets-backward "Back")
  ("]" corral-brackets-forward "Forward")
  ("{" corral-braces-backward "Back")
  ("}" corral-braces-forward "Forward")
  ("." hydra-repeat "Repeat"))
(global-set-key (kbd "C->") 'hydra-corral/body)


(provide 'init-hydra)
