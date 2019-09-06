;; Web mode
(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.twig\\'" . web-mode)
  ("\\.vue\\'" . web-mode)
  :custom
  (web-mode-script-padding global-indentation-size)
  (web-mode-style-padding global-indentation-size)
  (web-mode-block-padding global-indentation-size)
  (web-mode-attr-indent-offset global-indentation-size)
  (web-mode-attr-value-indent-offset global-indentation-size)
  (web-mode-enable-current-element-highlight t)
  (web-mode-content-types-alist '(("jsx" . "\\.[jt]?s[x]?\\'")
                                  ("vue" . "\\.vue\\'")))
  :config
  (set-face-background 'web-mode-current-element-highlight-face "#AF3A03"))


;; YAML mode
(use-package yaml-mode)


;; Emmet mode
(load (expand-file-name "custom-packages/emmet-mode/emmet-mode" user-emacs-directory))
(setq emmet-move-cursor-between-quotes t
      emmet-insert-flash-time 0.1)

(define-key emmet-mode-keymap (kbd "<C-return>") nil)

(add-hook 'web-mode-hook #'emmet-mode)


;; Markdown mode
(use-package markdown-mode
  :mode
  ("\\.mdx?\\'" . markdown-mode))


;; Impatient Mode
(use-package impatient-mode)



(provide 'init-markup)
