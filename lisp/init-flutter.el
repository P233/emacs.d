(use-package dart-mode
  :defer t
  :hook
  (dart-mode . (lambda ()
                 (add-hook 'before-save-hook 'lsp-format-buffer nil t))))

(use-package flutter
  :after dart-mode
  :config
  (setq flutter-sdk-path "~/flutter"))

(use-package lsp-dart
  :after (dart-mode lsp-mode)
  :custom
  (lsp-dart-sdk-dir "~/flutter/bin/cache/dart-sdk/")
  (lsp-dart-flutter-sdk-dir "~/flutter")
  (lsp-dart-flutter-fringe-colors nil))


(provide 'init-flutter)
