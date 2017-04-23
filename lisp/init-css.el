(setq css-indent-offset global-indentation-size)

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(use-package rainbow-mode)

(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files (company-css :with company-dabbrev company-dabbrev-code)))
            (local-set-key (kbd "C-x C-s") 'stylefmt-sort-buffer)
            (rainbow-mode)
            (emmet-mode)))



(provide 'init-css)
