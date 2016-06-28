(use-package web-mode
  :mode
  ("\\.html?\\'" . web-mode)
  ("\\.hbs?\\'" . web-mode)
  ("\\.jsx\\'" . web-mode)
  :init
  (setq web-mode-attr-indent-offset global-indentation-size
        web-mode-script-padding global-indentation-size
        web-mode-style-padding global-indentation-size
        web-mode-enable-current-element-highlight t
        web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))


(use-package emmet-mode
  :init
  (setq emmet-move-cursor-between-quotes t
        emmet-insert-flash-time 0.1)
  :config
  (add-hook 'web-mode-hook 'emmet-mode)
  (define-key emmet-mode-keymap (kbd "<C-return>") nil))


(use-package yaml-mode)


(provide 'init-markup)
