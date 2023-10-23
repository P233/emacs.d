;; -*- lexical-binding: t; -*-
(use-package swift-mode
  :defer t
  :custom
  (swift-mode:multiline-statement-offset 0)
  (swift-mode:basic-offset my/indentation-size))


(provide 'init-swift)
