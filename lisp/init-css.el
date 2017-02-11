(setq css-indent-offset global-indentation-size)

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(add-hook 'scss-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files company-dabbrev-code company-dabbrev))
            ;; (flycheck-select-checker 'scss-lint)
            ;; (flycheck-mode)
            (local-set-key (kbd "C-x C-s") 'stylefmt-sort-buffer)
            (rainbow-mode)
            (emmet-mode)))



(provide 'init-css)
