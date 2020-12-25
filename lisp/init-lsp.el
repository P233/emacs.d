(setq lsp-keymap-prefix "C-l")

(use-package lsp-mode
  :custom
  (lsp-enable-file-watchers nil)
  (lsp-headerline-breadcrumb-enable nil)
  :hook
  ((web-mode . lsp)
   (js2-mode . lsp)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package which-key
  :config
  (which-key-mode))


(provide 'init-lsp)
