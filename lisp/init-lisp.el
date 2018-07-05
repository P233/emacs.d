;; Parinfer mode
(use-package parinfer
  :init
  (setq parinfer-extensions '(defaults pretty-parens evil smart-tab smart-yank))
  :config
  (add-hook 'clojure-mode-hook 'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook 'parinfer-mode))



(provide 'init-lisp)
