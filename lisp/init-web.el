;; -*- lexical-binding: t; -*-
(add-to-list 'auto-mode-alist '("\\.js$"  . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.ts$"  . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . tsx-ts-mode))

(setq css-indent-offset my/indentation-size)
(add-hook 'css-mode-hook 'electric-pair-local-mode)
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
  ((css-mode tsx-ts-mode) . emmet2-mode))

(use-package prettier-js
  :defer t
  :hook
  ((css-mode js-ts-mode typescript-ts-mode tsx-ts-mode json-ts-mode) . prettier-js-mode))


(provide 'init-web)
