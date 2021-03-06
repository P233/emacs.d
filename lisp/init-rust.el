(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :hook
  (flycheck-mode . flycheck-rust-setup)
  (rust-mode . (lambda ()
                 (racer-mode)
                 (flycheck-mode))))

(use-package flycheck-rust
  :after (rust-mode flycheck))

(use-package racer
  :after rust-mode
  :hook
  (racer-mode . eldoc-mode))

(use-package cargo
  :after rust-mode)

(use-package rust-playground
  :after rust-mode
  :custom
  (rust-playground-basedir "~/Projects/rust-playground"))


(provide 'init-rust)
