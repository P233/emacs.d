(use-package js2-mode
  :mode "\\.js\\'"
  :custom
  (js2-basic-offset my/indentation-size)
  (js2-highlight-level 3)
  (js2-mode-show-parse-errors nil)
  (js2-mode-show-strict-warnings nil)
  :hook
  (js2-mode . prettier-js-mode))

(use-package typescript-mode
  :custom
  (typescript-indent-level my/indentation-size)
  :hook
  (typescript-mode . prettier-js-mode))

(use-package json-mode
  :custom
  (js-indent-level my/indentation-size)
  :hook
  (json-mode . (lambda ()
                 (add-hook 'before-save-hook 'prettier-js nil 'local))))


(provide 'init-javascript)
