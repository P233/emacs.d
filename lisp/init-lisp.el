;; Parinfer
(use-package parinfer
  :init
  (setq parinfer-extensions '(defaults pretty-parens evil smart-tab smart-yank))
  :config
  (add-hook 'emacs-lisp-mode-hook 'parinfer-mode))



(provide 'init-lisp)
