(use-package dart-mode
  :custom
  (dart-format-on-save t)
  (dart-sdk-path "~/flutter/bin/cache/dart-sdk/"))

(use-package flutter
  :after dart-mode
  :custom
  (flutter-sdk-path "~/flutter/"))



(provide 'init-flutter)
