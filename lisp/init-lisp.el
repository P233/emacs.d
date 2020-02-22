;; Lispy
(use-package lispy)


;; Parinfer mode
(use-package parinfer
  :custom
  (parinfer-extensions '(defaults pretty-parens lispy smart-tab smart-yank))
  :config
  (add-hook 'clojure-mode-hook #'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook #'parinfer-mode))


;; Clojure and ClojureScript mode
(use-package clojure-mode
  :custom
  (clojure-indent-style :align-arguments))


;; Cider Repl
(use-package cider)



(provide 'init-lisp)
