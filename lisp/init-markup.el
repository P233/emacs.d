(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.jsx\\'"  . web-mode)
  ("\\.tsx\\'"  . web-mode)
  :init
  (setq web-mode-script-padding global-indentation-size
        web-mode-style-padding global-indentation-size
        web-mode-block-padding global-indentation-size
        web-mode-attr-indent-offset global-indentation-size
        web-mode-attr-value-indent-offset global-indentation-size
        web-mode-enable-current-element-highlight t
        web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))


(use-package emmet-mode
  :init
  (setq emmet-move-cursor-between-quotes t
        emmet-insert-flash-time 0.1)
  :config
  (add-hook 'web-mode-hook 'emmet-mode)
  (define-key emmet-mode-keymap (kbd "<C-return>") nil))


(use-package markdown-mode
  :mode
  ("README\\.md\\'" . gfm-mode)
  ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "multimarkdown")
  :config
  ;; brew install aspell --with-lang-en
  (add-hook 'markdown-mode-hook 'turn-on-flyspell))


(use-package yaml-mode)



(provide 'init-markup)
