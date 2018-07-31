;; Web mode
(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.js[x]?\\'" . web-mode)
  :init
  (setq web-mode-script-padding global-indentation-size
        web-mode-style-padding global-indentation-size
        web-mode-block-padding global-indentation-size
        web-mode-attr-indent-offset global-indentation-size
        web-mode-attr-value-indent-offset global-indentation-size
        web-mode-enable-current-element-highlight t
        web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))
  :config
  (define-key web-mode-map (kbd "C-c C-s") nil)) ;; ignore web-mode-snippet-insert

;; YAML mode
(use-package yaml-mode)

;; Emmet mode
;; (package-install-file "custom-packages/emmet-mode/emmet-mode.el")
(setq emmet-move-cursor-between-quotes t
      emmet-insert-flash-time 0.1)
(add-hook 'emmet-mode-hook
          (lambda ()
            (define-key emmet-mode-keymap (kbd "<C-return>") nil)))


(provide 'init-markup)
