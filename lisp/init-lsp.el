(setq lsp-keymap-prefix "C-l")

(use-package lsp-mode
  :custom
  (lsp-enable-snippet nil)
  (lsp-enable-file-watchers nil)
  (lsp-headerline-breadcrumb-enable nil)
  :hook
  (((web-mode css-mode js2-mode clojure-mode swift-mode) . lsp)
   (lsp-mode . electric-pair-local-mode)
   (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)

(use-package which-key
  :config
  (which-key-mode))


(provide 'init-lsp)
