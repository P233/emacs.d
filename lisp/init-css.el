(use-package postcss-sorting)

(setq css-indent-offset global-indentation-size)
(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-tabnine (company-dabbrev-code :with company-css) company-files))
            (add-hook 'before-save-hook 'postcss-sorting-buffer nil 'local)
            (emmet-mode)))


(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))



(provide 'init-css)
