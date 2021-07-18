(use-package js2-mode
  :mode "\\.js\\'"
  :custom
  (js2-basic-offset my/indentation-size)
  (js2-highlight-level 3)
  (js2-mode-show-parse-errors nil)
  (js2-mode-show-strict-warnings nil))

(use-package typescript-mode
  :custom
  (typescript-indent-level my/indentation-size))

(use-package json-mode
  :custom
  (js-indent-level my/indentation-size)
  :hook
  (json-mode . (lambda ()
                 (add-hook 'before-save-hook 'prettier-js nil 'local))))


(provide 'init-javascript)
