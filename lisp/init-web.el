;; -*- lexical-binding: t; -*-
(use-package web-mode
  :mode
  ("\\.html\\'" "\\.[jt]sx?\\'" "\\.[cm]js\\'" "\\.astro\\'")
  :custom
  (web-mode-block-padding my/indentation-size)
  (web-mode-style-padding my/indentation-size)
  (web-mode-script-padding my/indentation-size)
  (web-mode-attr-indent-offset my/indentation-size)
  (web-mode-attr-value-indent-offset my/indentation-size)
  (web-mode-enable-auto-indentation nil)
  (web-mode-enable-current-element-highlight t)
  :hook
  (web-mode . (lambda ()
                (when (string-equal web-mode-content-type "jsx")
                  (setq-local web-mode-auto-quote-style 3))
                (lsp-bridge-mode)
                (electric-pair-local-mode)))
  :config
  (defun my/web-mode-attribute-complete ()
    (interactive)
    (when (acm-frame-visible-p acm-frame)
      (acm-complete)
      (insert "=")
      (web-mode-auto-complete)))
  (add-to-list 'acm-continue-commands 'my/web-mode-attribute-complete)
  :bind
  (:map web-mode-map
        ("C-c C-r" . nil)
        ("C-c C-s" . nil)
        ("C-c C-c C-r" . web-mode-reload)
        ("C-=" . my/web-mode-attribute-complete)))

(setq css-indent-offset my/indentation-size)
(add-hook 'css-mode-hook 'electric-pair-local-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(use-package json-mode
  :defer t
  :custom
  (js-indent-level my/indentation-size))

(use-package yaml-mode
  :defer t)

(use-package markdown-mode
  :mode "\\.mdx?\\'")

(use-package prettier-js
  :defer t
  :hook
  ((web-mode css-mode markdown-mode json-mode) . prettier-js-mode))


(provide 'init-web)
