(use-package lispy)

(use-package parinfer-rust-mode
  :custom
  (parinfer-rust-auto-download t)
  :hook
  ((emacs-lisp-mode clojure-mode) . parinfer-rust-mode))

(use-package clojure-mode)

(use-package cider
  :after clojure-mode)


(provide 'init-lisp)
