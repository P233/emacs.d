;; Tide
(use-package tide)


;; Prettier mode
(use-package prettier-js)


;; ESlint fix
(use-package eslint-fix)


;; My/js-minor-modes
(defun my/js-minor-modes ()
  (add-node-modules-path)
  (prettier-js-mode)
  (tide-setup)
  (tide-hl-identifier-mode)
  (setq-local company-backends '((company-tide :with company-tabnine :separate))))


;; JS2 mode
(use-package js2-mode
  :mode "\\.js\\'"
  :custom
  (js2-basic-offset global-indentation-size)
  (js2-highlight-level 3)
  (js2-mode-show-parse-errors nil)
  (js2-mode-show-strict-warnings nil)
  :config
  (add-hook 'js2-mode-hook #'my/js-minor-modes))


;; TypeScript mode
(use-package typescript-mode
  :custom
  (typescript-indent-level global-indentation-size)
  :config
  (add-hook 'typescript-mode-hook #'my/js-minor-modes))


;; Web mode settnigs for JSX / TSX
(add-to-list 'magic-mode-alist '("import.*react" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (if (equal web-mode-content-type "jsx")
                (progn
                  (setq-local emmet-expand-jsx-className? t)
                  (setq-local web-mode-enable-auto-quoting nil)
                  (my/js-minor-modes))
              (if (equal web-mode-content-type "vue")
                  (my/js-minor-modes)))))


;; JSON mode
(use-package json-mode
  :custom
  (js-indent-level global-indentation-size))



(provide 'init-javascript)
