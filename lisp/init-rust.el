;; -*- lexical-binding: t; -*-
(use-package rust-mode
  :defer t
  :custom
  (rust-format-on-save t)
  :hook
  (rust-mode . lsp-bridge-mode))

(use-package cargo
  :defer t
  :after rust-mode)

(use-package rust-playground
  :defer t
  :after rust-mode
  :custom
  (rust-playground-basedir "~/Projects/rust-playground"))


(provide 'init-rust)
