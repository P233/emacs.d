;; -*- lexical-binding: t; -*-
(use-package swift-mode
  :config
  (setq swift-mode:basic-offset my/indentation-size))

(use-package lsp-sourcekit
  :after lsp-mode
  :config
  (setq lsp-sourcekit-executable "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))


(provide 'init-swift)
