(setq css-indent-offset global-indentation-size)

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(add-hook 'scss-mode-hook
          (lambda ()
            (flycheck-select-checker 'scss-lint)
            (flycheck-mode)
            (emmet-mode)))


(provide 'init-css)
