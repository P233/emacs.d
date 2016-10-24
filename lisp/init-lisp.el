;; Clojure(Script)
(use-package clojure-mode
  :init
  (setq clojure-indent-style :align-arguments))


;; Parinfer
(use-package parinfer
  :init
  (setq parinfer-extensions '(defaults evil))
  :config
  (add-hook 'emacs-lisp-mode-hook 'parinfer-mode)
  (add-hook 'clojure-mode-hook 'parinfer-mode))



(provide 'init-lisp)
