(use-package rainbow-mode)

(use-package postcss-sorting)

(setq css-indent-offset global-indentation-size)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files (company-css :with company-dabbrev company-dabbrev-code)))
            (add-hook 'before-save-hook 'postcss-sorting-buffer nil 'local)
            (rainbow-mode)
            (emmet-mode)))



(provide 'init-css)
