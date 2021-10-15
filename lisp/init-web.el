;; -*- lexical-binding: t; -*-
(load (concat user-emacs-directory "custom-packages/emmet-mode/emmet-mode"))
(setq emmet-move-cursor-between-quotes t
      emmet-insert-flash-time 0.1)
(define-key emmet-mode-keymap (kbd "<C-return>") nil)

(use-package web-mode
  :mode
  ("\\.html\\'" "\\.[jt]sx?\\'" "\\.vue\\'" "\\.svelte\\'")
  :init
  (add-to-list 'magic-mode-alist '("import.*react" . web-mode))
  :config
  (setq web-mode-content-types-alist '(("jsx" . "\\.[jt]sx?\\'")
                                       ("vue" . "\\.vue\\'"))
        web-mode-block-padding my/indentation-size
        web-mode-style-padding my/indentation-size
        web-mode-script-padding my/indentation-size
        web-mode-attr-indent-offset my/indentation-size
        web-mode-attr-value-indent-offset my/indentation-size
        web-mode-enable-current-element-highlight t
        web-mode-enable-auto-indentation nil)
  (set-face-background 'web-mode-current-element-highlight-face "#AF3A03")
  :hook
  (web-mode . (lambda ()
                (when (equal web-mode-content-type "jsx")
                  (setq-local emmet-expand-jsx-className? t
                              web-mode-enable-auto-quoting nil))
                (emmet-mode)
                (electric-pair-local-mode))))

(setq css-indent-offset my/indentation-size)
(add-hook 'css-mode-hook
          (lambda ()
            (emmet-mode)
            (electric-pair-local-mode)))
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(use-package json-mode
  :defer t
  :config
  (setq js-indent-level my/indentation-size))

(use-package yaml-mode :defer t)

(use-package markdown-mode
  :mode "\\.mdx?\\'")

(use-package prettier-js
  :defer t
  :hook ((web-mode css-mode markdown-mode json-mode) . prettier-js-mode))


(provide 'init-web)
