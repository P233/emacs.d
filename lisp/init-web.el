;; -*- lexical-binding: t; -*-
(setq js-indent-level my/indentation-size
      css-indent-offset my/indentation-size)

(add-to-list 'auto-mode-alist '("\\.js$"  . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.mjs$" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts$"  . typescript-ts-mode))

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(add-to-list 'auto-mode-alist '("\\.json$" . json-ts-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-ts-mode))

(use-package tsx-ts-helper-mode
  :straight (:type git :host codeberg :repo "ckruse/tsx-ts-helper-mode")
  :custom
  (tsx-ts-helper-mode-auto-close-tags nil)
  (tsx-ts-helper-mode-keymap-prefix (kbd "C-c C-e"))
  :hook
  (tsx-ts-mode . tsx-ts-helper-mode))

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
  :mode
  ("\\.html\\'" "\\.astro\\'")
  :custom
  (web-mode-block-padding my/indentation-size)
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
