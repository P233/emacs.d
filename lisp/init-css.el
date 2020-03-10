(use-package postcss-sorting)

(defun my/css-before-save-hook ()
  (postcss-sorting-buffer)
  (format-all-buffer))

(setq css-indent-offset global-indentation-size)
(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-css company-tabnine))
            (add-hook 'before-save-hook 'my/css-before-save-hook nil 'local)
            (emmet-mode)))


(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))



(provide 'init-css)
