(use-package tide)

(use-package eslint-fix)

(use-package add-node-modules-path)

(defun my/js-minor-modes ()
  (add-node-modules-path)
  (tide-setup)
  (tide-hl-identifier-mode)
  (flycheck-mode)
  (flycheck-select-checker 'javascript-eslint)
  (prettier-js-mode)
  (setq-local company-backends '((company-tide :with company-tabnine :separate))))

(use-package js2-mode
  :mode "\\.js\\'"
  :custom
  (js2-basic-offset my/indentation-size)
  (js2-highlight-level 3)
  (js2-mode-show-parse-errors nil)
  (js2-mode-show-strict-warnings nil)
  :hook
  (js2-mode . my/js-minor-modes))

(use-package typescript-mode
  :custom
  (typescript-indent-level my/indentation-size)
  :hook
  (typescript-mode . my/js-minor-modes))

(add-hook 'web-mode-hook
          (lambda ()
            (pcase web-mode-content-type
              ("jsx" (progn
                       (setq-local emmet-expand-jsx-className? t)
                       (setq-local web-mode-enable-auto-quoting nil)
                       (my/js-minor-modes)))
              ("vue" (my/js-minor-modes))
              ("html" (prettier-js-mode)))))

(use-package json-mode
  :custom
  (js-indent-level my/indentation-size)
  :hook
  (json-mode . (lambda ()
                 (add-hook 'before-save-hook 'prettier-js nil 'local))))


(provide 'init-javascript)
