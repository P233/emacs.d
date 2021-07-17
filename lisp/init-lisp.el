(use-package lispy)

(use-package parinfer-rust-mode
  :custom
  (parinfer-rust-auto-download t)
  :hook emacs-lisp-mode)

(defun my/clj-minor-modes ()
  (parinfer-mode)
  (flycheck-mode))

(use-package clojure-mode
  :hook
  (clojure-mode . my/clj-minor-modes)
  (clojurescript-mode . my/clj-minor-modes))

(use-package cider
  :after clojure-mode)

(use-package flycheck-clj-kondo
  :init
  (dolist (checker '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
    (setq flycheck-checkers (cons checker (delq checker flycheck-checkers)))))


(provide 'init-lisp)
