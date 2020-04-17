(setq css-indent-offset my/indentation-size)

(use-package postcss-sorting)

(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files (company-css :with company-dabbrev company-dabbrev-code)))
            (add-hook 'before-save-hook #'prettier-js nil 'local)
            (emmet-mode)))

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))


(provide 'init-css)
