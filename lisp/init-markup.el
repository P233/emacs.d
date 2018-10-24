;; Web mode
(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.twig\\'" . web-mode)
  :init
  (setq web-mode-script-padding global-indentation-size
        web-mode-style-padding global-indentation-size
        web-mode-block-padding global-indentation-size
        web-mode-attr-indent-offset global-indentation-size
        web-mode-attr-value-indent-offset global-indentation-size
        web-mode-enable-current-element-highlight t
        web-mode-content-types-alist '(("jsx" . "\\.[jt]?s[x]?\\'")))
  :config
  (set-face-background 'web-mode-current-element-highlight-face "#AF3A03")
  :hook
  (web-mode . emmet-mode))


;; YAML mode
(use-package yaml-mode)


;; Emmet mode
(add-to-list 'load-path (expand-file-name "custom-packages/emmet-mode" user-emacs-directory))
(require 'emmet-mode)
(setq emmet-move-cursor-between-quotes t
      emmet-insert-flash-time 0.1)

(define-key emmet-mode-keymap (kbd "<C-return>") nil)



(provide 'init-markup)
