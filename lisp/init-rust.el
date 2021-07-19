;; -*- lexical-binding: t; -*-
(use-package rust-mode
  :defer t
  :config
  (setq rust-format-on-save t)
  :hook
  (flycheck-mode . flycheck-rust-setup)
  (rust-mode . (lambda ()
                 (racer-mode)
                 (flycheck-mode))))

(use-package flycheck-rust
  :defer t
  :after (rust-mode flycheck))

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
  :config
  (setq rust-playground-basedir "~/Projects/rust-playground"))


(provide 'init-rust)
