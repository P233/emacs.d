(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :hook
  (rust-mode . racer-mode))


(use-package racer
  :hook
  (racer-mode . eldoc-mode))


(use-package rust-playground
  :custom
  (rust-playground-basedir "~/Desktop/rust-playground"))



(provide 'init-rust)
