;; npm install -g tern
(use-package tern
  :init
  (setq tern-command '("tern" "--no-port-file")))

(use-package company-tern)


(defun my-js-minor-modes ()
  "set local company-backends, and enable eslint & tern"
  (setq-local company-backends '(company-files (company-tern :with company-dabbrev)))
  (flycheck-select-checker 'javascript-eslint)
  (flycheck-mode)
  (tern-mode))


;; JSX confings
(add-hook 'web-mode-hook
          (lambda ()
            (when (equal web-mode-content-type "jsx")
              (setq-local emmet-expand-jsx-className? t) ; enable emmet className completion
              (my-js-minor-modes))))


(use-package js2-mode
  :mode
  ("\\.js$" . js2-mode)
  :init
  (setq js2-basic-offset global-indentation-size
        js-switch-indent-offset global-indentation-size
        js2-mode-show-parse-errors nil
        js2-mode-show-strict-warnings nil)
  :config
  (add-hook 'js2-mode-hook 'my-js-minor-modes))


(use-package json-mode
  :init
  (setq js-indent-level global-indentation-size))



(provide 'init-javascript)
