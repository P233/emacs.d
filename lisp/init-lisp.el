;; -*- lexical-binding: t; -*-
(use-package elisp-mode
  :straight (:type built-in)
  :defer t
  :config
  (unbind-key "C-c C-f" emacs-lisp-mode-map))


(provide 'init-lisp)
