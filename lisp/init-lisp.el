;; -*- lexical-binding: t; -*-
(use-package lispy :defer t)

(use-package parinfer-rust-mode
  :defer t
  :config
  (setq parinfer-rust-auto-download t)
  :hook
  ((emacs-lisp-mode clojure-mode) . parinfer-rust-mode))

(use-package clojure-mode :defer t)

(use-package cider
  :defer t
  :after clojure-mode)


(provide 'init-lisp)
