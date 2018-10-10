;; Tide
(use-package tide)

(defun setup-tide-mode ()
  (tide-setup)
  (eldoc-mode)
  (tide-hl-identifier-mode)
  (prettier-js-mode))


;; Prettier mode
(use-package prettier-js)


;; JS2 mode
(use-package js2-mode
  :mode "\\.js\\'"
  :init
  (setq js2-basic-offset global-indentation-size
        js2-highlight-level 3
        js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil)
  :config
  (add-hook 'js2-mode-hook
            (lambda ()
              (setq-local prettier-js-command "prettier-standard")
              (setup-tide-mode))))
              ;; (flycheck-select-checker 'javascript-standard)
              ;; (flycheck-mode))))


;; RJSX mode
(use-package rjsx-mode
  :init
  (add-to-list 'magic-mode-alist '("import.*react" . rjsx-mode))
  :config
  (add-hook 'rjsx-mode-hook
            (lambda()
              (emmet-mode)
              (setq-local emmet-expand-jsx-className? t))))


;; TypeScript mode
(use-package typescript-mode
  :init
  (setq typescript-indent-level global-indentation-size)
  :config
  (add-hook 'typescript-mode-hook #'setup-tide-mode))


;; JSON mode
(use-package json-mode
  :init
  (setq js-indent-level global-indentation-size))



(provide 'init-javascript)
