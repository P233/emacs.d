(use-package dart-mode
  :defer t)

(use-package flutter
  :after dart-mode
  :config
  (setq flutter-sdk-path "~/flutter"))


(provide 'init-flutter)
