;; -*- lexical-binding: t; -*-
(setq js-indent-level my/indentation-size
      css-indent-offset my/indentation-size)

(use-package emmet2-mode
  :straight (:type git :host github :repo "p233/emmet2-mode" :files (:defaults "*.ts" "src" "data"))
  :after deno-bridge
  :hook
  ((css-mode tsx-ts-mode web-mode) . emmet2-mode))

(use-package prettier-js
  :defer t
  :hook
  ((css-mode js-ts-mode typescript-ts-mode tsx-ts-mode json-ts-mode web-mode) . prettier-js-mode))

(use-package web-mode
  :custom
  (web-mode-block-padding 0)
  (web-mode-style-padding my/indentation-size)
  (web-mode-script-padding my/indentation-size)
  (web-mode-attr-indent-offset my/indentation-size)
  (web-mode-attr-value-indent-offset my/indentation-size)
  (web-mode-enable-auto-indentation nil)
  (web-mode-enable-current-element-highlight t)
  :custom-face
  (web-mode-html-tag-face ((t (:inherit font-lock-function-name-face :foreground unspecified))))
  (web-mode-html-attr-name-face ((t (:inherit font-lock-type-face :foreground unspecified))))
  (web-mode-current-element-highlight-face ((t (:background "#3f6faf")))))


(provide 'init-web)
