;; Parinfer mode
(use-package parinfer
  :init
  (setq parinfer-extensions '(defaults pretty-parens smart-tab smart-yank)
        parinfer-auto-switch-indent-mode t)
  :config
  (add-hook 'clojure-mode-hook 'parinfer-mode)
  (add-hook 'emacs-lisp-mode-hook 'parinfer-mode))



(provide 'init-lisp)
