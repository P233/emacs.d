;; -*- lexical-binding: t; -*-
(use-package lispy
  :defer t)

(use-package paredit
  :defer t
  :hook
  ((emacs-lisp-mode clojure-mode) . paredit-mode))

(use-package clojure-mode
  :defer t)

(use-package cider
  :defer t
  :after clojure-mode)


(provide 'init-lisp)
