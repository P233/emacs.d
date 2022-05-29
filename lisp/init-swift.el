;; -*- lexical-binding: t; -*-
(use-package swift-mode
  :defer t
  :custom
  (swift-mode:basic-offset my/indentation-size))

(use-package lsp-sourcekit
  :after lsp-mode
  :custom
  (lsp-sourcekit-executable "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp"))

(use-package swift-format
  :load-path "custom-packages/swift-format"
  :after swift-mode
  :hook
  (swift-mode . (lambda ()
                  (add-hook 'before-save-hook 'swift-format-buffer nil t))))


(provide 'init-swift)
