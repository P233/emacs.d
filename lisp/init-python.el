;; -*- lexical-binding: t; -*-
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-ts-mode))

(use-package python-black
  :hook
  (python-ts-mode . python-black-on-save-mode))

(use-package lpy
  :hook
  (python-ts-mode . lpy-mode))


(provide 'init-python)
