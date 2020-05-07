(use-package lispy)

(use-package parinfer
  :custom
  (parinfer-extensions '(defaults pretty-parens lispy smart-tab smart-yank))
  :hook
  (clojure-mode . parinfer-mode)
  (clojurescript-mode . parinfer-mode)
  (emacs-lisp-mode . parinfer-mode)
  :bind
  ("C-;" . parinfer-toggle-mode))

(use-package clojure-mode
  :custom
  (clojure-indent-style :align-arguments))

(use-package cider
  :after clojure-mode)

(use-package flycheck-clj-kondo
  :init
  (dolist (checker '(clj-kondo-clj clj-kondo-cljs clj-kondo-cljc clj-kondo-edn))
    (setq flycheck-checkers (cons checker (delq checker flycheck-checkers)))))


(provide 'init-lisp)
