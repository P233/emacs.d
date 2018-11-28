(use-package rainbow-mode)

(use-package postcss-sorting)

(setq css-indent-offset global-indentation-size)
(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files (company-css :with company-dabbrev company-dabbrev-code)))
            (add-hook 'before-save-hook 'postcss-sorting-buffer nil 'local)
            (rainbow-mode)
            (emmet-mode)))


(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(add-hook 'scss-mode-hook
          (lambda ()
            (setq-local emmet-use-scss-syntax t)))



(provide 'init-css)
