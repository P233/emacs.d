;; Allows Emacs to find project based installs
(use-package add-node-modules-path)


;; Tide
(use-package tide)

(defun setup-tide-mode ()
  (tide-setup)
  (tide-hl-identifier-mode))


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
              (add-node-modules-path)
              (prettier-js-mode)
              (setup-tide-mode))))
              ;; (flycheck-mode))))


;; TypeScript mode
(use-package typescript-mode
  :init
  (setq typescript-indent-level global-indentation-size)
  :config
  (add-hook 'typescript-mode-hook #'setup-tide-mode))


;; Web mode settnigs for JSX / TSX
(add-to-list 'magic-mode-alist '("import.*react" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              (if (string-match "js[x]?" (file-name-extension buffer-file-name))
                  (setq-local prettier-js-command "prettier-standard"))
              (setq-local emmet-expand-jsx-className? t)
              (setq-local web-mode-enable-auto-quoting nil)
              (add-node-modules-path)
              (prettier-js-mode)
              (setup-tide-mode))))


;; JSON mode
(use-package json-mode
  :init
  (setq js-indent-level global-indentation-size))



(provide 'init-javascript)
