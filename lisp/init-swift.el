;; -*- lexical-binding: t; -*-
(use-package swift-mode
  :defer t)

(use-package lsp-sourcekit
  :defer t
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))


(provide 'init-swift)
