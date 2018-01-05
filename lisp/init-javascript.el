(defun my-js-minor-modes ()
  "Shared minor modes for both js2-mode and web-mode (JSX)."
  (setq-local company-backends '(company-files (company-tern :with company-dabbrev)))
  ;; (flycheck-select-checker 'javascript-eslint)
  ;; (flycheck-mode)
  (prettier-js-mode)
  (tern-mode))


;; Tern mode
(use-package tern
  :init
  (setq tern-command '("tern" "--no-port-file")))

(use-package company-tern)


;; Prettier mode
(use-package prettier-js
  :init
  (setq prettier-js-args '(
                           "--print-width" "100"
                           "--trailing-comma" "all"
                           "--single-quote" "true")))


;; JSON mode
(use-package json-mode
  :init
  (setq js-indent-level global-indentation-size))


;; Add support for JSX
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              (setq-local emmet-expand-jsx-className? t)
              (setq-local web-mode-enable-auto-quoting nil)
              (my-js-minor-modes))))



(provide 'init-javascript)
