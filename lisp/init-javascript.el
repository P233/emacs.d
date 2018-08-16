(defun my/js-minor-modes ()
  "Shared minor modes for both js2-mode and web-mode (JSX)."
  (setq-local company-backends '(company-files (company-tern :with company-dabbrev)))
  (flycheck-select-checker 'javascript-standard)
  (flycheck-mode)
  (prettier-js-mode)
  (tern-mode))


;; JS2 mode
(use-package js2-mode)


;; TypeScript mode
(use-package typescript-mode
  :init
  (setq typescript-indent-level global-indentation-size))


;; Tide
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (prettier-js-mode)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(use-package tide
  :init
  (add-hook 'before-save-hook 'tide-format-before-save)
  (add-hook 'typescript-mode-hook #'setup-tide-mode))


;; Tern mode
(use-package tern
  :init
  (setq tern-command '("tern" "--no-port-file")))

(use-package company-tern)


;; Prettier mode
(use-package prettier-js
  :init
  (setq prettier-js-args '(
                           "--print-width" "120"
                           "--trailing-comma" "all"
                           "--single-quote" "true")))


;; JSON mode
(use-package json-mode
  :init
  (setq js-indent-level global-indentation-size))


;; Add support for JSX
(add-hook 'web-mode-hook
          (lambda ()
            (emmet-mode)
            (when (equal web-mode-content-type "jsx")
              (setq-local emmet-expand-jsx-className? t)
              (setq-local web-mode-enable-auto-quoting nil)
              (my/js-minor-modes))))


(provide 'init-javascript)
