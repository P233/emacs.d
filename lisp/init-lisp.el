;; -*- lexical-binding: t; -*-
(use-package lispy
  :defer t
  :hook
  ((emacs-lisp-mode clojure-mode) . (lambda ()
                                      (lispy-mode)
                                      (lsp-bridge-mode))))

(use-package clojure-mode
  :defer t)

(use-package cider
  :after clojure-mode)


(provide 'init-lisp)
