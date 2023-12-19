(use-package python-black
  :hook
  (python-ts-mode . python-black-on-save-mode))


(provide 'init-python)
