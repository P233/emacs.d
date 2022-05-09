;; -*- lexical-binding: t; -*-
(use-package emmet-mode
  :load-path "custom-packages/emmet-mode"
  :custom
  (emmet-insert-flash-time 0.1)
  (emmet-move-cursor-between-quotes t)
  :config
  (unbind-key "<C-return>" emmet-mode-keymap))

(use-package web-mode
  :mode
  ("\\.html\\'" "\\.[jt]sx?\\'" "\\.vue\\'" "\\.svelte\\'")
  :config
  (add-to-list 'web-mode-comment-formats '("jsx" . "//" ))
  :custom
  (web-mode-content-types-alist '(("jsx" . "\\.[jt]sx?\\'")
                                  ("vue" . "\\.vue\\'")))
  (web-mode-block-padding my/indentation-size)
  (web-mode-style-padding my/indentation-size)
  (web-mode-script-padding my/indentation-size)
  (web-mode-attr-indent-offset my/indentation-size)
  (web-mode-attr-value-indent-offset my/indentation-size)
  (web-mode-enable-current-element-highlight t)
  (web-mode-enable-auto-indentation nil)
  (web-mode-enable-current-element-highlight nil)
  :hook
  (web-mode . (lambda ()
                (when (equal web-mode-content-type "jsx")
                  (setq-local emmet-expand-jsx-className? t
                              web-mode-enable-auto-quoting nil))
                (emmet-mode)
                (electric-pair-local-mode)))
  :bind
  (:map web-mode-map
        ("C-c C-r" . nil)
        ("C-c C-s" . nil)
        ("C-c C-c C-r" . web-mode-reload)))

(setq css-indent-offset my/indentation-size)
(add-hook 'css-mode-hook
          (lambda ()
            (emmet-mode)
            (electric-pair-local-mode)))
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
