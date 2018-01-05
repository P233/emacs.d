(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(setq css-indent-offset global-indentation-size)

(use-package rainbow-mode)

(use-package postcss-sorting)

(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files (company-css :with company-dabbrev company-dabbrev-code)))
            (local-set-key (kbd "C-x C-s") 'postcss-sorting-buffer)
            (rainbow-mode)
            (emmet-mode)))



(provide 'init-css)
