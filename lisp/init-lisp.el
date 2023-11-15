;; -*- lexical-binding: t; -*-
(use-package elisp-mode
  :straight (:type built-in)
  :config
  (unbind-key "C-c C-f" emacs-lisp-mode-map))

(use-package paredit
  :hook
  (emacs-lisp-mode . paredit-mode))


(provide 'init-lisp)
