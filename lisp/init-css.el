(setq css-indent-offset my/indentation-size)

(use-package postcss-sorting)

(defun my/css-before-save-hook ()
  (postcss-sorting-buffer)
  (prettier-js))

(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files (company-css :with company-dabbrev company-dabbrev-code)))
            (add-hook 'before-save-hook 'my/css-before-save-hook nil 'local)
            (emmet-mode)))

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))


(provide 'init-css)
