(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :hook
  (rust-mode . racer-mode))


(use-package racer
  :hook
  (racer-mode . eldoc-mode))



(provide 'init-rust)
