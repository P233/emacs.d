;; Lispy
(use-package lispy)

;; Parinfer mode
(use-package parinfer
  :init
  (setq parinfer-extensions '(defaults pretty-parens lispy smart-tab smart-yank))
  (add-hook 'clojure-mode-hook #'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
  :bind
  ("C-c p" . parinfer-toggle-mode))


;; Clojure and ClojureScript mode
(use-package clojure-mode
  :init
  (setq clojure-indent-style :align-arguments))

(use-package cider)


(provide 'init-lisp)
