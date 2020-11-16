(use-package web-mode
  :mode
  ("\\.html\\'" "\\.[jt]sx?\\'" "\\.vue\\'" "\\.svelte\\'" "\\.twig\\'")
  :init
  (add-to-list 'magic-mode-alist '("import.*react" . web-mode))
  :custom
  (web-mode-block-padding my/indentation-size)
  (web-mode-style-padding my/indentation-size)
  (web-mode-script-padding my/indentation-size)
  (web-mode-attr-indent-offset my/indentation-size)
  (web-mode-attr-value-indent-offset my/indentation-size)
  (web-mode-enable-current-element-highlight t)
  (web-mode-content-types-alist '(("jsx" . "\\.[jt]sx?\\'")
                                  ("vue" . "\\.vue\\'")))
  :config
  (set-face-background 'web-mode-current-element-highlight-face "#AF3A03")
  :hook
  (web-mode . (lambda ()
                (when (equal web-mode-content-type "jsx")
                  (progn
                    (setq-local emmet-expand-jsx-className? t)
                    (setq-local web-mode-enable-auto-quoting nil)))
                (emmet-mode)
                (prettier-js-mode))))

(use-package markdown-mode
  :mode "\\.mdx?\\'"
  :hook
  (markdown-mode . (lambda ()
                     (add-hook 'before-save-hook 'prettier-js nil 'local))))

(use-package yaml-mode)


(provide 'init-markup)
