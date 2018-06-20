;;----------------------------------------------------------------------------
;; Markup
;;----------------------------------------------------------------------------

;; Web mode
(use-package web-mode
  :mode
  ("\\.html\\'" . web-mode)
  ("\\.js[x]?\\'" . web-mode)
  :init
  (setq web-mode-script-padding global-indentation-size
        web-mode-style-padding global-indentation-size
        web-mode-block-padding global-indentation-size
        web-mode-attr-indent-offset global-indentation-size
        web-mode-attr-value-indent-offset global-indentation-size
        web-mode-enable-current-element-highlight t
        web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))


;; Markdown mode
(use-package markdown-mode
  :mode
  ("README\\.md\\'" . gfm-mode)
  ("\\.md\\'" . markdown-mode)
  :init
  (setq markdown-command "multimarkdown")
  :config
  (add-hook 'markdown-mode-hook 'turn-on-flyspell))


;; YAML mode
(use-package yaml-mode)


;; Emmet mode
;; (package-install-file "custom-packages/emmet-mode/emmet-mode.el")
(setq emmet-move-cursor-between-quotes t
      emmet-insert-flash-time 0.1)
(add-hook 'emmet-mode-hook
          (lambda ()
            (define-key emmet-mode-keymap (kbd "<C-return>") nil)))


;;----------------------------------------------------------------------------
;; SCSS
;;----------------------------------------------------------------------------

(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))

(setq css-indent-offset global-indentation-size)

(use-package rainbow-mode)

(use-package postcss-sorting)

(add-hook 'css-mode-hook
          (lambda ()
            (setq-local company-backends '(company-files (company-css :with company-dabbrev company-dabbrev-code)))
            (local-set-key (kbd "C-x C-s") 'postcss-sorting-buffer)
            (rainbow-mode)
            (emmet-mode)))


;;----------------------------------------------------------------------------
;; JavaScript
;;----------------------------------------------------------------------------

(defun my-js-minor-modes ()
  "Shared minor modes for both js2-mode and web-mode (JSX)."
  (setq-local company-backends '(company-files (company-tern :with company-dabbrev)))
  ;; (flycheck-select-checker 'javascript-eslint)
  ;; (flycheck-mode)
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
  :config
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
              (my-js-minor-modes))))


;;----------------------------------------------------------------------------
;; end
;;----------------------------------------------------------------------------

(provide 'init-front-end)
