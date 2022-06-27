;; -*- lexical-binding: t; -*-
(use-package rust-mode
  :defer t
  :custom
  (rust-format-on-save t)
  :hook
  (rust-mode . racer-mode))

(use-package racer
  :defer t
  :after rust-mode
  :hook
  (racer-mode . eldoc-mode))

(use-package cargo
  :defer t
  :after rust-mode)

(use-package rust-playground
  :defer t
  :after rust-mode
  :custom
  (rust-playground-basedir "~/Projects/rust-playground"))


(provide 'init-rust)
