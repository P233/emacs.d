(use-package lispy)

(use-package parinfer
  :custom
  (parinfer-extensions '(defaults pretty-parens lispy smart-tab smart-yank))
  :hook
  (emacs-lisp-mode . parinfer-mode)
  :bind
  ("C-;" . parinfer-toggle-mode))

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
