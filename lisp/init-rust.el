(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :hook
  (flycheck-mode . flycheck-rust-setup)
  (rust-mode . (lambda ()
                 (racer-mode)
                 (flycheck-mode))))


(use-package racer
  :hook
  (racer-mode . eldoc-mode))


(use-package flycheck-rust)


(use-package cargo)


(use-package rust-playground
  :custom
  (rust-playground-basedir "~/Projects/rust-playground"))



(provide 'init-rust)
