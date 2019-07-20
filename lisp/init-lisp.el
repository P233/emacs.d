;; Lispy
(use-package lispy)


;; Parinfer mode
(use-package parinfer
  :custom
  (parinfer-extensions '(defaults pretty-parens lispy smart-tab smart-yank))
  :config
  (add-hook 'emacs-lisp-mode-hook #'parinfer-mode))



(provide 'init-lisp)
