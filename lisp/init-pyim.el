(use-package chinese-pyim
  :config
  (use-package chinese-pyim-basedict
    :init
    (setq default-input-method "chinese-pyim")
    (chinese-pyim-basedict-enable)))


(provide 'init-pyim)
